USE MASTER
GO
IF EXISTS(SELECT NAME FROM SYS.DATABASES WHERE NAME='QLSV')
	DROP DATABASE QLSV
GO
CREATE DATABASE QLSV

GO
USE QLSV
GO
CREATE TABLE LOP
(
	MALOP CHAR(7) NOT NULL,
	TENLOP NVARCHAR(50) UNIQUE(TENLOP),
	SISO TINYINT CHECK(SISO BETWEEN 20 AND 60),
	PRIMARY KEY(MALOP)
)
GO
CREATE TABLE MONHOC
(
	MAMH CHAR(6),
	TENMH NVARCHAR(50) NOT NULL,
	TCLT TINYINT CHECK(TCLT>=0),
	TCTH TINYINT CHECK(TCTH>=0),
	PRIMARY KEY(MAMH)
)
GO
CREATE TABLE SINHVIEN
(
	MSSV CHAR(6),
	HOTEN NVARCHAR(100) NOT NULL,
	NTNS DATETIME CHECK(YEAR(GETDATE())-YEAR(NTNS)>=18),
	PHAI BIT CHECK(PHAI IN(0,1)) DEFAULT '1',
	MALOP CHAR(7) NOT NULL,
	PRIMARY KEY(MSSV),
	FOREIGN KEY(MALOP) REFERENCES LOP(MALOP) ON UPDATE CASCADE
)
GO
CREATE TABLE DIEMSV
(
	MSSV CHAR(6),
	MAMH CHAR(6),
	DIEM FLOAT CHECK(DIEM IS NULL OR DIEM BETWEEN 0 AND 10),
	PRIMARY KEY(MSSV,MAMH),
	FOREIGN KEY(MSSV) REFERENCES SINHVIEN(MSSV) ON UPDATE CASCADE,
	FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH) ON UPDATE CASCADE
)
GO
INSERT LOP VALUES ('18DTH01',N'CNTT Khóa 18 Lớp 1',50)
INSERT LOP VALUES ('18DTH02',N'CNTT Khóa 18, Lớp 2',45)
INSERT LOP VALUES ('19DTH01',N'CNTT Khóa 19, Lớp 1',55)
INSERT LOP VALUES ('19DTH02',N'CNTT Khóa 19, Lớp 2',50)
INSERT LOP VALUES ('19DTH03',N'CNTT Khóa 19, Lớp 3',40)
GO
INSERT MONHOC VALUES ('COS201',N'Kỹ thuật lập trình',2,1)
INSERT MONHOC VALUES ('COS202',N'Lý thuyết đồ thị',2,1)
INSERT MONHOC VALUES ('COS203',N'CSDLvà quản trị CSDL',3,0)
INSERT MONHOC VALUES ('COS204',N'Phân tích thiết kế hệ thống',3,0)
INSERT MONHOC VALUES ('COS205',N'CSDL phân tán',3,0)
GO
SET DATEFORMAT DMY
GO
INSERT SINHVIEN VALUES ('170001',N'Lê Hoài An','12/10/1999',1,'18DTH01')
INSERT SINHVIEN VALUES ('180002',N'Nguyễn Thị Hòa Bình','20/11/2000',1,'18DTH01')
INSERT SINHVIEN VALUES ('180003',N'Phạm Tường Châu','07/06/2000',0,'18DTH02')
INSERT SINHVIEN VALUES ('180004',N'Trần Công Danh','31/01/2000',0,'19DTH01')
GO
INSERT DIEMSV VALUES ('170001','COS201',10.0)
INSERT DIEMSV VALUES ('170001','COS202',10.0)
INSERT DIEMSV VALUES ('170001','COS203',10.0)
INSERT DIEMSV VALUES ('170001','COS204',10.0)
INSERT DIEMSV VALUES ('170001','COS205',10.0)
INSERT DIEMSV VALUES ('180002','COS201',3.5)
INSERT DIEMSV VALUES ('180002','COS202',7.0)
INSERT DIEMSV VALUES ('180003','COS201',8.5)
INSERT DIEMSV VALUES ('180003','COS202',2.0)
INSERT DIEMSV VALUES ('180003','COS203',6.5)
INSERT DIEMSV VALUES ('180004','COS201',8.0)
INSERT DIEMSV VALUES ('180004','COS204',NULL)


--Thực hiện các câu hỏi sau bằng ngôn ngữ SQL:
--1-	Thêm một dòng mới vào bảng SINHVIEN với giá trị:


--XOÁ THỬ
DELETE FROM SINHVIEN WHERE MSSV='190001'

SELECT * FROM SINHVIEN
--2-	Hãy đổi tên môn học ‘Lý thuyết đồ thị ’thành ‘Toán rời rạc’.


SELECT * FROM MONHOC
--3-	Hiển thị tên các môn học không có thực hành.

--4-	Hiển thị tên các môn học vừa có lý thuyết, vừa có thực hành.

--5-	In ra tên các môn học có ký tự đầu của tên là chữ ‘C’.

--6-	Liệt kê thông tin những sinh viên mà họ chứa chữ ‘Thị’.

--7-	In ra 2 lớp có sĩ số đông nhất (bằng nhiều cách). 
--Hiển thị: Mã lớp, Tên lớp, Sĩ số. Nhận xét?
--C1

--C2

--C3

--8-	In danh sách SV theo từng lớp: MSSV, Họ tên SV, Năm sinh, Phái (Nam/Nữ).

--9-	Cho biết những sinh viên có tuổi ≥ 20, thông tin gồm: Họ tên sinh viên, Ngày sinh, Tuổi.

--10-	Liệt kê tên các môn học SV đã dự thi nhưng chưa có điểm.

--11-	Liệt kê kết quả học tập của SV có mã số 170001. Hiển thị: MSSV, HoTen, TenMH, Diem.

--12-	Liệt kê tên sinh viên và mã môn học mà sv đó đăng ký với điểm trên 7 điểm.

--13-	Liệt tên môn học cùng số lượng SV đã học và đã có điểm.

--14-	Liệt kê tên SV và điểm trung bình của SV đó.

--15-	Liệt kê tên sinh viên đạt điểm cao nhất của môn học ‘Kỹ thuật lập trình’.

--16-	Liệt kê tên SV có điểm trung bình cao nhất.

--17-	Liệt kê tên SV chưa học môn ‘Toán rời rạc’.

--18-	Cho biết sinh viên có năm sinh cùng với sinh viên tên ‘Danh’.

--19-	Cho biết tổng sinh viên và tổng số sinh viên nữ.

--20-	Cho biết danh sách các sinh viên rớt ít nhất 1 môn.

--21-	Cho biết MSSV, Họ tên SV đã học và có điểm ít nhất 3 môn.

--22-	In danh sách sinh viên có điểm môn ‘Kỹ thuật lập trình’ cao nhất theo từng lớp.

--KẾT QUẢ CỦA SINH VIÊN

--ĐIỂM CAO NHẤT CỦA TỪNG LỚP MÔN KỸ THUẬT LẬP TRÌNH

--23-	In danh sách sinh viên có điểm cao nhất theo từng môn, từng lớp.

--KẾT QUẢ THI CỦA SINH VIÊN

--ĐIỂM CAO NHẤT CỦA TỪNG MÔN THEO TỪNG LỚP



--24-	Cho biết những sinh viên đạt điểm cao nhất của từng môn.


--25-	Cho biết MSSV, Họ tên SV chưa đăng ký học môn nào.

--27-	Đếm số sinh viên nam, nữ theo từng lớp.

--28-	Cho biết những sinh viên đã học tất cả các môn nhưng không rớt môn nào.

--29-	Xoá tất cả những sinh viên chưa dự thi môn nào.

--30-	Cho biết những môn đã được tất cả các sinh viên đăng ký học.
