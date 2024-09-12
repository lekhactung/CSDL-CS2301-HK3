use CSDLDe3
go

--(1?) T?o ràng bu?c, SL trong b?ng CTHD ph?i l?n h?n 0.
alter table CTHD
add constraint chk_sl
check (SL>0)
--2 (1?) T?o ràng bu?c s? ?i?n tho?i c?a khách hàng ph?i duy nh?t.
--alter table KHACHHANG 
--drop constraint uq_sdt_KH
alter table KHACHHANG
add constraint uq_sdt_KH
unique(SoDT)
--3 (1?) T?o ràng bu?c ngày hóa ??n trong b?ng hóa ??n có giá tr? m?c ??nh là ngày hi?n
--t?i.
alter table HOADON
add constraint df_ngayHD
default getdate() for NgayHD
--4 (1?) Vi?t câu truy v?n thêm m?i m?t khách hàng v?i thông tin c?a sinh viên vào b?ng
--Khách Hàng
select * from KHACHHANG
insert into KHACHHANG (MaKH,HoKH,TenKH,DChi,SoDT,NgSinh,NgayDK)
values ('KH04','Lê Kh??c','Tu?ng','A4 Era Town','0965838224','07-10-2005','11-09-2024')
--5 (1?) Thêm c?t DiaDiem vào b?ng NhanVien. Sau ?ó s?a giá tr? c?a c?t DiaDiem ?
--nhân viên c?a các nhân viên là Tp HCM.
select * from NHANVIEN

alter table NHANVIEN
add DiaDiem nvarchar(100)

ALTER TABLE NHANVIEN
drop column DiaDiem

update NHANVIEN
set DiaDiem = 'TP.HCM'
--6 (1?) V?i t?ng nhân viên, ??m s? l??ng ??n hàng mà nhân viên ?ã l?p, s?p x?p gi?m
--d?n theo s? l??ng ??n hàng. Các c?t hi?n th? bao g?m: mã nhân viên, tên nhân viên, s?
--l??ng ??n hàng.

select nv.MaNV , nv.TenNV , count(nv.MaNV) as SoLuongDonHang
from NHANVIEN nv,HOADON hd
where hd.MaNV = nv.MaNV
group by nv.MaNV , nv.TenNV 
order by SoLuongDonHang desc
--7 (1?) Hi?n th? t?ng doanh thu ?ã bán trong n?m 2016. (t?ng doanh thu = t?ng
--(SLxDonGia)).

select sum(SL*DonGia)
from CTHD ct,HOADON hd
where ct.MaHD = hd.SoHD and year(hd.NgayHD) = 2016

--8 (1?) T?o câu query l?y danh sách các s?n ph?m ch?a ???c b?t k? khách hàng nào mua
--trong n?m 2016.
select * 
from SANPHAM sp
where sp.MaSP not in(
	select sp.MaSP
	from HOADON hd, CTHD ct, SANPHAM sp
	where  hd.SoHD = ct.MaHD and sp.MaSP = ct.MaSP and year(hd.NgayHD) = 2016
)

--9 (1?) T?o câu query th?ng kê s? l??ng s?n ph?m do t?ng qu?c gia s?n xu?t, s?p x?p
--theo th? t? gi?m d?n c?a s? l??ng s?n ph?m. Câu truy v?n này s? t?o ra 1 b?ng m?i g?m
--2 c?t: tên qu?c gia và s? l??ng s?n ph?m

select sp.NuocSX , sum(ct.SL) as SoLuongSanPham
from SANPHAM sp, CTHD ct
where ct.MaSP = sp.MaSP
group by sp.NuocSX
order by SoLuongSanPham desc
--10 (1?) Vi?t câu truy v?n thông kê cho bi?t t?ng m?t hàng ?ã ???c bán v?i t?ng s? l??ng
--là bao nhiêu, và c? th? trong t?ng quý trong n?m 2016 là bao nhiêu. G?m có: các dòng là
--các tên m?t hang, các c?t là t?ng s? l??ng và s? l??ng theo t?ng quý.

select TenSP, isnull([1],0) + isnull([2],0) + isnull([3],0) + isnull([4],0) as TongSL,
isnull([1],0) Q1, isnull([2],0) Q2 , isnull([3],0) Q3, isnull([4],0) Q4 
from (
	select sp.TenSP, sum(ct.SL) as SoLuong,DATEPART(q,hd.NgayHD) as Quy
	from SANPHAM sp, HOADON hd, CTHD ct
	where sp.MaSP = ct.MaSP and 
		hd.SoHD = ct.MaHD and
		year(hd.NgayHD) = 2016
	group by sp.TenSP, DATEPART(q,hd.NgayHD)
)A 
pivot (
	sum(SoLuong)for Quy in ([1],[2],[3],[4])
)B
