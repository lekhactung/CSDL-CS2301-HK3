use CSDLDe3
go

--(1?) T?o r�ng bu?c, SL trong b?ng CTHD ph?i l?n h?n 0.
alter table CTHD
add constraint chk_sl
check (SL>0)
--2 (1?) T?o r�ng bu?c s? ?i?n tho?i c?a kh�ch h�ng ph?i duy nh?t.
--alter table KHACHHANG 
--drop constraint uq_sdt_KH
alter table KHACHHANG
add constraint uq_sdt_KH
unique(SoDT)
--3 (1?) T?o r�ng bu?c ng�y h�a ??n trong b?ng h�a ??n c� gi� tr? m?c ??nh l� ng�y hi?n
--t?i.
alter table HOADON
add constraint df_ngayHD
default getdate() for NgayHD
--4 (1?) Vi?t c�u truy v?n th�m m?i m?t kh�ch h�ng v?i th�ng tin c?a sinh vi�n v�o b?ng
--Kh�ch H�ng
select * from KHACHHANG
insert into KHACHHANG (MaKH,HoKH,TenKH,DChi,SoDT,NgSinh,NgayDK)
values ('KH04','L� Kh??c','Tu?ng','A4 Era Town','0965838224','07-10-2005','11-09-2024')
--5 (1?) Th�m c?t DiaDiem v�o b?ng NhanVien. Sau ?� s?a gi� tr? c?a c?t DiaDiem ?
--nh�n vi�n c?a c�c nh�n vi�n l� Tp HCM.
select * from NHANVIEN

alter table NHANVIEN
add DiaDiem nvarchar(100)

ALTER TABLE NHANVIEN
drop column DiaDiem

update NHANVIEN
set DiaDiem = 'TP.HCM'
--6 (1?) V?i t?ng nh�n vi�n, ??m s? l??ng ??n h�ng m� nh�n vi�n ?� l?p, s?p x?p gi?m
--d?n theo s? l??ng ??n h�ng. C�c c?t hi?n th? bao g?m: m� nh�n vi�n, t�n nh�n vi�n, s?
--l??ng ??n h�ng.

select nv.MaNV , nv.TenNV , count(nv.MaNV) as SoLuongDonHang
from NHANVIEN nv,HOADON hd
where hd.MaNV = nv.MaNV
group by nv.MaNV , nv.TenNV 
order by SoLuongDonHang desc
--7 (1?) Hi?n th? t?ng doanh thu ?� b�n trong n?m 2016. (t?ng doanh thu = t?ng
--(SLxDonGia)).

select sum(SL*DonGia)
from CTHD ct,HOADON hd
where ct.MaHD = hd.SoHD and year(hd.NgayHD) = 2016

--8 (1?) T?o c�u query l?y danh s�ch c�c s?n ph?m ch?a ???c b?t k? kh�ch h�ng n�o mua
--trong n?m 2016.
select * 
from SANPHAM sp
where sp.MaSP not in(
	select sp.MaSP
	from HOADON hd, CTHD ct, SANPHAM sp
	where  hd.SoHD = ct.MaHD and sp.MaSP = ct.MaSP and year(hd.NgayHD) = 2016
)

--9 (1?) T?o c�u query th?ng k� s? l??ng s?n ph?m do t?ng qu?c gia s?n xu?t, s?p x?p
--theo th? t? gi?m d?n c?a s? l??ng s?n ph?m. C�u truy v?n n�y s? t?o ra 1 b?ng m?i g?m
--2 c?t: t�n qu?c gia v� s? l??ng s?n ph?m

select sp.NuocSX , sum(ct.SL) as SoLuongSanPham
from SANPHAM sp, CTHD ct
where ct.MaSP = sp.MaSP
group by sp.NuocSX
order by SoLuongSanPham desc
--10 (1?) Vi?t c�u truy v?n th�ng k� cho bi?t t?ng m?t h�ng ?� ???c b�n v?i t?ng s? l??ng
--l� bao nhi�u, v� c? th? trong t?ng qu� trong n?m 2016 l� bao nhi�u. G?m c�: c�c d�ng l�
--c�c t�n m?t hang, c�c c?t l� t?ng s? l??ng v� s? l??ng theo t?ng qu�.

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
