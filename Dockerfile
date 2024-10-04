FROM ubuntu:latest

MAINTAINER Tuan Thai "tuanthai@example.com"

# Cập nhật và cài đặt các gói cần thiết, bao gồm python3.12 và python3.12-venv
RUN apt update -y && \
    apt install -y python3.12 python3.12-venv python3-pip build-essential curl

# Tạo thư mục cho app
ADD . /flask_app
WORKDIR /flask_app

# Tạo môi trường ảo và cài đặt pip nếu chưa có
RUN python3.12 -m venv venv && \
    ./venv/bin/python -m ensurepip --upgrade && \
    ./venv/bin/python -m pip install --upgrade pip setuptools

# Cài đặt dependencies
RUN ./venv/bin/python -m pip install --no-cache-dir -r requirements.txt

# Khởi động ứng dụng Flask
CMD ["./venv/bin/python", "flask_docker.py"]
