-- 1. Người dùng
CREATE TABLE NguoiDung (
    Manguoidung VARCHAR(20) PRIMARY KEY,
    Tendangnhap NVARCHAR(100) NOT NULL UNIQUE,
    matkhau VARCHAR(MAX) NOT NULL,
    Hoten NVARCHAR(200),
    Email NVARCHAR(200) UNIQUE,
    Vaitro NVARCHAR(20) CHECK (Vaitro IN ('Admin', 'PM', 'Accountant', 'Employee')),
    Ngaytao DATETIME DEFAULT GETDATE(),
    Trangthai BIT DEFAULT 1
);

-- 2. Dự án
CREATE TABLE DuAn (
    Maduan VARCHAR(20) PRIMARY KEY,
    Tenduan NVARCHAR(200) NOT NULL,
    Motada NVARCHAR(MAX),
    Ngaybatdau DATE,
    Ngayketthuc DATE,
    Trangthai NVARCHAR(20) CHECK (Trangthai IN ('Planning', 'InProgress', 'Completed', 'OnHold')),
    Nguoitao VARCHAR(20),
    FOREIGN KEY (Nguoitao) REFERENCES NguoiDung(Manguoidung)
);

-- 3. Công việc
CREATE TABLE CongViec (
    Macongviec VARCHAR(20) PRIMARY KEY,
    Maduan VARCHAR(20) NOT NULL,
    Tieude NVARCHAR(200) NOT NULL,
    Mota NVARCHAR(MAX),
    Trangthai NVARCHAR(20) CHECK (Trangthai IN ('Todo', 'InProgress', 'Done')),
    Mucdouutien NVARCHAR(10) CHECK (Mucdouutien IN ('Low', 'Medium', 'High')),
    Ngaybatdau DATE,
    Dateline DATE,
    Nguoitao VARCHAR(20),
    FOREIGN KEY (Maduan) REFERENCES DuAn(Maduan),
    FOREIGN KEY (Nguoitao) REFERENCES NguoiDung(Manguoidung)
);

-- 4. Phân công
CREATE TABLE PhanCong (
    Ma_phancong VARCHAR(20) PRIMARY KEY,
    Macongviec VARCHAR(20) NOT NULL,
    Manguoidung VARCHAR(20) NOT NULL,
    Ngayphancong DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Macongviec) REFERENCES CongViec(Macongviec),
    FOREIGN KEY (Manguoidung) REFERENCES NguoiDung(Manguoidung)
);

-- 5. Bảng chấm công
CREATE TABLE ChamCong (
    Mabangchamcong VARCHAR(20) PRIMARY KEY,
    Manguoidung VARCHAR(20) NOT NULL,
    Macongviec VARCHAR(20) NOT NULL,
    Ngaylamviec DATE NOT NULL,
    Sogiolam DECIMAL(5,2) CHECK (Sogiolam >= 0),
    Trangthai NVARCHAR(20) CHECK (Trangthai IN ('Pending', 'Approved', 'Rejected')),
    Nguoiduyet VARCHAR(20),
    Ngaytao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Manguoidung) REFERENCES NguoiDung(Manguoidung),
    FOREIGN KEY (Macongviec) REFERENCES CongViec(Macongviec),
    FOREIGN KEY (Nguoiduyet) REFERENCES NguoiDung(Manguoidung)
);

-- 6. Nghỉ phép / Làm thêm
CREATE TABLE NghiPhep (
    Manghiphep VARCHAR(20) PRIMARY KEY,
    Manguoidung VARCHAR(20) NOT NULL,
    Loainghiphep NVARCHAR(10) CHECK (Loainghiphep IN ('Leave', 'OT')),
    Ngaybatdau DATE NOT NULL,
    Ngayketthuc DATE NOT NULL,
    Sogiolam DECIMAL(5,2) CHECK (Sogiolam >= 0),
    Trangthai NVARCHAR(20) CHECK (Trangthai IN ('Pending', 'Approved', 'Rejected')),
    Nguoiduyet VARCHAR(20),
    FOREIGN KEY (Manguoidung) REFERENCES NguoiDung(Manguoidung),
    FOREIGN KEY (Nguoiduyet) REFERENCES NguoiDung(Manguoidung)
);

-- 7. Chính sách trả lương
CREATE TABLE ChinhSachLuong (
    Machinhsach VARCHAR(20) PRIMARY KEY,
    Luonggiocoban DECIMAL(10,2) CHECK (Luonggiocoban >= 0),
    Hesonhanlamthem DECIMAL(5,2) CHECK (Hesonhanlamthem >= 1),
    Quytaclamtron NVARCHAR(50),
    Hieulucngay DATE NOT NULL
);

-- 8. Chạy lương
CREATE TABLE ChayBangLuong (
    Machayluong VARCHAR(20) PRIMARY KEY,
    Ngaybatdaukyluong DATE NOT NULL,
    Ngayketthuckyluong DATE NOT NULL,
    Trangthai NVARCHAR(20) CHECK (Trangthai IN ('Draft', 'Completed')),
    Ngaytao DATETIME DEFAULT GETDATE()
);

-- 9. Phiếu lương
CREATE TABLE PhieuLuong (
    Maphieuluong VARCHAR(20) PRIMARY KEY,
    Machayluong VARCHAR(20) NOT NULL,
    Manguoidung VARCHAR(20) NOT NULL,
	Machinhsach VARCHAR(20) NOT NULL,
    Tonggiolam DECIMAL(10,2) CHECK (Tonggiolam >= 0),
    Tonggiolamthem DECIMAL(10,2) CHECK (Tonggiolamthem >= 0),
    Tongluong DECIMAL(12,2) CHECK (Tongluong >= 0),
    Khoantru DECIMAL(12,2) CHECK (Khoantru >= 0),
    Luongnhanduoc DECIMAL(12,2) CHECK (Luongnhanduoc >= 0),
    Ngaytao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Machayluong) REFERENCES ChayBangLuong(Machayluong),
    FOREIGN KEY (Manguoidung) REFERENCES NguoiDung(Manguoidung),
	FOREIGN KEY (Machinhsach) REFERENCES ChinhSachLuong(Machinhsach)
);

-- 10. Nhật ký kiểm tra
CREATE TABLE Audit_Log (
    Madangky VARCHAR(20) PRIMARY KEY,
    Manguoidung VARCHAR(20) NOT NULL,
    Hanhdong NVARCHAR(100) NOT NULL,
    Tentable NVARCHAR(100) NOT NULL,
    Madulieu VARCHAR(20) NOT NULL,
    Thoigian DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Manguoidung) REFERENCES NguoiDung(Manguoidung)
);


SELECT * FROM NguoiDung;
SELECT * FROM DuAn;
SELECT * FROM CongViec;
SELECT * FROM PhanCong;
SELECT * FROM ChamCong;
SELECT * FROM NghiPhep;
SELECT * FROM ChinhSachLuong;
SELECT * FROM ChayBangLuong;
SELECT * FROM PhieuLuong;
SELECT * FROM Audit_Log;

DROP TABLE IF EXISTS Audit_Log;
DROP TABLE IF EXISTS PhieuLuong;
DROP TABLE IF EXISTS ChayBangLuong;
DROP TABLE IF EXISTS ChinhSachLuong;
DROP TABLE IF EXISTS NghiPhep;
DROP TABLE IF EXISTS ChamCong;
DROP TABLE IF EXISTS PhanCong;
DROP TABLE IF EXISTS CongViec;
DROP TABLE IF EXISTS DuAn;
DROP TABLE IF EXISTS NguoiDung;


DELETE FROM Audit_Log;
DELETE FROM PhieuLuong;
DELETE FROM ChayBangLuong;
DELETE FROM ChinhSachLuong;
DELETE FROM NghiPhep;
DELETE FROM ChamCong;
DELETE FROM PhanCong;
DELETE FROM CongViec;
DELETE FROM DuAn;
DELETE FROM NguoiDung;



INSERT INTO NguoiDung (Manguoidung, Tendangnhap, Matkhau, Hoten, Email, Vaitro)
VALUES
('ND001', 'admin01', '123456@A', N'Nguyễn Văn Quản Trị', 'admin01@company.com', 'Admin'),
('ND002', 'pm01', '123456@B', N'Lê Thị Quản Lý', 'pm01@company.com', 'PM'),
('ND003', 'acc01', '123456@C', N'Phạm Minh Kế Toán', 'acc01@company.com', 'Accountant'),
('ND004', 'nv01', '123456@D', N'Trần Hữu Nhân Viên', 'nv01@company.com', 'Employee'),
('ND005', 'nv02', '123456@E', N'Đỗ Thị Công Nhân', 'nv02@company.com', 'Employee');

INSERT INTO DuAn (Maduan, Tenduan, Motada, Ngaybatdau, Ngayketthuc, Trangthai, Nguoitao)
VALUES
('DA001', N'Hệ thống chấm công', N'Phát triển module chấm công tự động', '2025-01-01', '2025-06-30', 'InProgress', 'ND002'),
('DA002', N'Cổng nhân sự', N'Phát triển HR Portal cho nội bộ công ty', '2025-03-01', '2025-09-30', 'Planning', 'ND002'),
('DA003', N'Tính lương tự động', N'Xây dựng module tính lương theo giờ làm việc', '2025-02-01', '2025-07-15', 'Completed', 'ND002');


INSERT INTO CongViec (Macongviec, Maduan, Tieude, Mota, Trangthai, Mucdouutien, Ngaybatdau, Dateline, Nguoitao)
VALUES
('CV001', 'DA001', N'Thiết kế giao diện chấm công', N'Giao diện nhập và duyệt chấm công', 'InProgress', 'High', '2025-01-05', '2025-02-10', 'ND002'),
('CV002', 'DA001', N'Xây dựng API chấm công', N'API kết nối mobile & web', 'Todo', 'Medium', '2025-01-10', '2025-03-01', 'ND002'),
('CV003', 'DA003', N'Kiểm thử module tính lương', N'Test độ chính xác khi tính hệ số OT', 'Done', 'Low', '2025-03-10', '2025-04-15', 'ND002');


INSERT INTO PhanCong (Ma_phancong, Macongviec, Manguoidung)
VALUES
('PC001', 'CV001', 'ND004'),
('PC002', 'CV002', 'ND005'),
('PC003', 'CV003', 'ND004');


INSERT INTO ChamCong (Mabangchamcong, Manguoidung, Macongviec, Ngaylamviec, Sogiolam, Trangthai, Nguoiduyet)
VALUES
('CC001', 'ND004', 'CV001', '2025-05-01', 8.0, 'Approved', 'ND002'),
('CC002', 'ND004', 'CV001', '2025-05-02', 7.5, 'Pending', 'ND002'),
('CC003', 'ND005', 'CV002', '2025-05-01', 6.5, 'Approved', 'ND002');


INSERT INTO NghiPhep (Manghiphep, Manguoidung, Loainghiphep, Ngaybatdau, Ngayketthuc, Sogiolam, Trangthai, Nguoiduyet)
VALUES
('NP001', 'ND004', 'Leave', '2025-05-05', '2025-05-06', 0, 'Approved', 'ND002'),
('NP002', 'ND005', 'OT', '2025-05-03', '2025-05-03', 3.5, 'Approved', 'ND002'),
('NP003', 'ND004', 'Leave', '2025-06-01', '2025-06-01', 0, 'Pending', 'ND002');


INSERT INTO ChinhSachLuong (Machinhsach, Luonggiocoban, Hesonhanlamthem, Quytaclamtron, Hieulucngay)
VALUES
('CS001', 50000, 1.5, 'RoundNearest', '2025-01-01'),
('CS002', 60000, 2.0, 'RoundUp', '2025-03-01'),
('CS003', 70000, 1.7, 'RoundDown', '2025-05-01');

INSERT INTO ChayBangLuong (Machayluong, Ngaybatdaukyluong, Ngayketthuckyluong, Trangthai)
VALUES
('CL001', '2025-05-01', '2025-05-31', 'Completed'),
('CL002', '2025-06-01', '2025-06-30', 'Completed'),
('CL003', '2025-07-01', '2025-07-31', 'Draft');


INSERT INTO PhieuLuong (Maphieuluong, Machayluong, Manguoidung, Machinhsach, Tonggiolam, Tonggiolamthem, Tongluong, Khoantru, Luongnhanduoc)
VALUES
('PL001', 'CL001', 'ND004', 'CS001', 160, 10, 8500000, 500000, 8000000),
('PL002', 'CL001', 'ND005', 'CS002', 170, 15, 10500000, 600000, 9900000),
('PL003', 'CL002', 'ND004', 'CS003', 150, 5, 8000000, 400000, 7600000);

INSERT INTO Audit_Log (Madangky, Manguoidung, Hanhdong, Tentable, Madulieu)
VALUES
('AL001', 'ND002', N'INSERT', N'ChamCong', 'CC001'),
('AL002', 'ND002', N'UPDATE', N'PhieuLuong', 'PL001'),
('AL003', 'ND001', N'DELETE', N'NghiPhep', 'NP003');



