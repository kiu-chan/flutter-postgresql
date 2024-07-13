# Đây là hướng dẫn kết nối flutter với postgresql

## Getting Started

### Các bước cài đặt (áp dụng với ubutu 24.04)

Truy cập các trang sau để lấy tài nguyên

- [Cài đặt postgresql](www.postgresql.org)
- [Các gói cần thiết cho flutter](https://pub.dev/)
- [Tham khảo 1](https://www.youtube.com/watch?v=8Qitb_OLicQ&list=PLPajU_HwKxoxJdwhTzyISXTDVmNXnaru5)
- [Tham khảo 2](https://www.youtube.com/watch?v=pG06Ml5C58E)

Các dependencies cần thiết bao gồm:
- postgres
- http

#### Cài đặt postgres trên ubuntu
```
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
```
#### Đặt mật khẩu cho tài khoản postgres và khởi động lại:
```
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'mật_khẩu_mới';"
sudo service postgresql restart
```

#### Đăng nhập:
```
psql -U postgres -W
```
#### Taọ dữ liệu mẫu
```
CREATE DATABASE students;

CREATE TABLE students_info (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INTEGER,
    grade VARCHAR(10)
);

INSERT INTO students_info (name, age, grade) VALUES
('Nguyễn Văn A', 15, '10A'),
('Phạm Thị B', 16, '11B'),
('Trần Văn C', 14, '9C');
```
#### Chạy server
```
node lib/databases/server.js
```
#### Chạy flutter

## 1 số lỗi

### Lỗi kết nối database
#### Thực hiện ping tới địa chỉ ip
```
ping <địa chỉ ip server>
```
để kiểm tra truy cập

#### Xác minh thông tin kết nối trong file cấu hình postgresql.conf của PostgreSQL:
```
sudo nano /etc/postgresql/<version>/main/postgresql.conf
```
sửa và bỏ dấu #
```
listen_addresses = '*'      # Cho phép lắng nghe từ tất cả các địa chỉ IP

```
khởi động lại 
```
sudo systemctl restart postgresql
```
