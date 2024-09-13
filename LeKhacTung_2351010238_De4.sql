use CSDLDe4
go
--1 (1đ) Tạo ràng buộc, SLNgayCong trong bảng PhanCong phải lớn hơn 0.
alter table PhanCong 
add constraint chk_slnc
check(SLNgayCong>0)
--2 (1đ) Tạo ràng buộc số TenCT trong bảng CongTrinh không được phép trùng.
alter table CongTrinh
add constraint uq_tenCT
unique(TenCT)

alter table CongTrinh
drop constraint uq_tenCT
--3 (1đ) Tạo ràng buộc ngày cấp quyết định trong bảng Công trình có giá trị mặc định là
--ngày hiện tại.
alter table CongTrinh
add constraint df_ngaycapqd
default getdate() for NgayCapQD
--4 (1đ) Viết câu truy vấn thêm mới một nhân viên với thông tin của sinh viên vào bảng
--Nhân viên
insert into NhanVien(MaNV,HoTen,NgaySinh,Phai,MaPB)
values ('006',N'Lê Khắc Tùng','07-10-2005','Nam','KT01')
--5 (1đ) Hãy cho biết số lượng nhân viên của mỗi Công trình. Thông tin bao gồm: Tên
--công trình, Số lượng nhân viên. Số lượng nhân viên được sắp xếp giảm dần.
select ct.TenCT, count(pc.MaNV) as 'Số lượng nhân viên'
from CongTrinh ct, PhanCong pc
where ct.MaCT =  pc.MaCT
group by ct.TenCT
order by count(pc.MaNV) desc
--6 (1đ) Lấy thông tin nhân viên có tổng số ngày công nhiều nhất trong năm 2016 và 2017.
select top 1 nv.HoTen , nv.MaNV, nv.MaPB, nv.NgaySinh, nv.Phai , sum(SLNgayCong) as TongSoNgayCong
from PhanCong pc, NhanVien nv
where pc.MaNV = nv.MaNV and 
	year(pc.NgayThamGia) between 2016 and 2017
group by nv.HoTen , nv.MaNV, nv.MaPB, nv.NgaySinh, nv.Phai
--7 (1đ) Tạo câu query lấy danh sách các nhân viên chưa tham gia bất kỳ công trình nào
--trong năm 2017.
select * 
from NhanVien
where MaNV not in (
	select distinct nv.MaNV
	from PhanCong pc, NhanVien nv
	where pc.MaNV = nv.MaNV and year(pc.NgayThamGia)  = 2017
)
--8 (1đ) Tạo câu query thống kê số lượng công trình từng nhân viên đã tham gia, sắp xếp
--theo thứ tự giảm dần của số lượng. Câu truy vấn này sẽ tạo ra 1 bảng mới gồm 2 cột: tên
--nhân viên và số lượng công trình.
create table SoLuongCongTrinh (
    TenNV nvarchar(200),
	SoLuongCongTrinh INT
)
insert into SoLuongCongTrinh (TenNV, SoLuongCongTrinh)
select nv.HoTen, count(pc.MaCT) as SoLuongCongTrinh
from NhanVien nv, PhanCong pc
where nv.MaNV = pc.MaNV 
group by nv.HoTen
order by SoLuongCongTrinh desc

select * from SoLuongCongTrinh
drop table SoLuongCongTrinh
--9 (1đ) Viết câu truy vấn thông kê cho biết từng phòng ban có bao nhiêu nhân viên tham
--gia công trình, và cụ thể trong từng công trình là bao nhiêu nhân viên. Gồm có: các dòng
--là các tên phòng ban, các cột là tổng số lượng và số lượng nhân viên theo từng mã công
--trình.

select TenPB as 'Ten Phong Ban',[CT001],[CT002],[CT003],[CT004], [CT001]+[CT002]+[CT003]+[CT004] as 'TongSL'
from (
	select TenPB, MaCT,pc.MaNV
	from PhongBan pb, PhanCong pc, NhanVien nv
	where pb.MaPB = nv.MaPB and nv.MaNV = pc.MaNV
)A
pivot (
	count (MaNV) for MaCT in ([CT001],[CT002],[CT003],[CT004])
)B
--10 (1đ) Thêm cột DiaDiemPhong vào bảng PhongBan. Sau đó sửa giá trị của cột
--DiaDiemPhong ở phòng Kinh doanh là Tp HCM.

alter table PhongBan
add DiaDiemPhong nvarchar(200) 

update PhongBan 
set DiaDiemPhong = 'Tp HCM' where TenPB = 'Kinh Doanh'
