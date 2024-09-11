--Tạo file HoTenSV_MSSV_De3.sql sau đó mở file này và thực hiện các câu truy vấn
--sau:
--1 (1đ) Tạo ràng buộc, SL trong bảng CTHD phải lớn hơn 0.
alter table CTHD
add constraint chk_sl_cthd
check (SL>0)
--2 (1đ) Tạo ràng buộc số điện thoại của khách hàng phải duy nhất.
alter table KHACHHANG
add constraint uq_sdt_KH
unique (SoDT)
--3 (1đ) Tạo ràng buộc ngày hóa đơn trong bảng hóa đơn có giá trị mặc định là ngày hiện
--tại.
alter table HOADON
add constraint df_ngayhd
default getdate() for NgayHD
--4 (1đ) Viết câu truy vấn thêm mới một khách hàng với thông tin của sinh viên vào bảng
--Khách Hàng
select * from KHACHHANG

insert into KHACHHANG (MaKH,HoKH,TenKH,DChi,SoDT,NgSinh,NgayDK)
values ('KH04','Lê Khắc','Tùng','A4 Era Town','0965838224','07-10-2005','11-09-2024')

--5 (1đ) Thêm cột DiaDiem vào bảng NhanVien. Sau đó sửa giá trị của cột DiaDiem ở
--nhân viên của các nhân viên là Tp HCM.
alter table NHANVIEN 
add DiaDiem nvchar(100)

update NHANVIEN
set DiaDiem = 'TP.HCM'

select * from NHANVIEN

--6 (1đ) Với từng nhân viên, đếm số lượng đơn hàng mà nhân viên đã lập, sắp xếp giảm
--dần theo số lượng đơn hàng. Các cột hiển thị bao gồm: mã nhân viên, tên nhân viên, số
--lượng đơn hàng.
--7 (1đ) Hiển thị tổng doanh thu đã bán trong năm 2016. (tổng doanh thu = tổng
--(SLxDonGia)).
--8 (1đ) Tạo câu query lấy danh sách các sản phẩm chưa được bất kỳ khách hàng nào mua
--trong năm 2016.
--9 (1đ) Tạo câu query thống kê số lượng sản phẩm do từng quốc gia sản xuất, sắp xếp
--theo thứ tự giảm dần của số lượng sản phẩm. Câu truy vấn này sẽ tạo ra 1 bảng mới gồm
--2 cột: tên quốc gia và số lượng sản phẩm
--10 (1đ) Viết câu truy vấn thông kê cho biết từng mặt hàng đã được bán với tổng số lượng
--là bao nhiêu, và cụ thể trong từng quý trong năm 2016 là bao nhiêu. Gồm có: các dòng là
--các tên mặt hang, các cột là tổng số lượng và số lượng theo từng quý.