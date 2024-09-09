create database ThucHanhDDL
use ThucHanhDDL
go 
create table Khoa(
	MaKhoa char(4) primary key,
	TenKhoa nvarchar (20) not null,
	NgayThanhLap datetime,
	NoiDungDaoTao nvarchar (200),
	GhiChu nvarchar (max)
)
create table Lop(
	MaLop char(6) primary key,
	TenLop nvarchar (20) not null,
	KhoaHoc nvarchar (4),
	GVCN nvarchar (50),
	MaKhoa char (4),
	GhiChu nvarchar (max),
	foreign key (MaKhoa) references Khoa(MaKhoa)
)

create table SinhVien(
	MaSV char(8) primary key,
	HoSV nvarchar (50) not null,
	TenSV text not null,
	GioiTinh nvarchar (4),
	NgaySinh datetime,
	QueQuan nvarchar (200),
	DiaChi nvarchar (100),
	MaLop char (6),
	GhiChu nvarchar (max),
	foreign key (MaLop) references Lop(MaLop)
)
create table MonHoc(
	MaMH int primary key,
	TenMH nvarchar (20) not null,
	NoiDungMH nvarchar (200),
	MaKhoa char (4),
	SoTinChi int,
	SoTiet int,
	GhiChu nvarchar (max),
	foreign key (MaKhoa) references Khoa(MaKhoa)
)
create table Hoc(
	MASV char (8),
	MaMH int,
	NgayDangKy datetime,
	NgayThi datetime, 
	DiemTrungBinh decimal (8,2),
	GhiChu nvarchar (max),
	primary key (MaSV, MaMH, NgayDangKy),
	foreign key (MaSV) references SinhVien(MaSV),
	foreign key (MaMH) references MonHoc(MaMH)
)
--thay doi ctruc bang da ton tai (them, xoa, sua)
alter table SinhVien
add CMND varchar (9);

alter table SinhVien
add DTDD varchar (10);

alter table SinhVien
alter column DTDD varchar (12)

alter table SinhVien
drop column DTDD
--10.	Viết câu lệnh tạo ràng buộc sau trong bảng Hoc: điểm của sinh viên phải nằm trong khoảng từ 0 đến 10.
alter table Hoc
add constraint chk_hoc_diemTb
check (DiemTrungBinh between 0 and 10)

--11.	Viết câu lệnh tạo ràng buộc sau trong bảng Hoc: Ngày thi phải sau ngày hiện tại và 
--ngày đăng ký có giá trị mặc định là ngày hiện tại
alter table Hoc
	add constraint chk_hoc_NgayThi
	check (NgayThi > getdate())
alter table Hoc 
	add constraint df_hoc_ngayDK
	default getdate() for NgayDangKy

--12.	Viết câu lệnh tạo ràng buộc sau trong bảng Sinh viên: Số CMND không được phép trùng
alter table SinhVien
	add constraint uq_sv_CMND
	unique (CMND)