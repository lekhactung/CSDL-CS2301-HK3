--1.	Tạo một query đặt tên là TimKhachHangMy (tìm khách hàng Mỹ). Khi chạy, query này sẽ tạo ra một table mới có tên CacKhachHangMy, lấy tất cả các field của bảng Customers. 
select * into TimKhachHangMy
from Customers
delete TimKhachHangMy
select * from TimKhachHangMy

--2.	Tạo một query đặt tên là Tim5NhanVienGioi (tìm 5 nhân viên giỏi). Khi chạy, query này sẽ tạo ra một table mới có tên 5NhanVienGioi.
--Bảng này liệt kê danh sách 5 nhân viên phụ trách nhiều đơn đặt hàng nhất. 
--Các thông tin gồm: mã nhân viên, họ và tên nhân viên (1 cột), tổng số lượng các đơn đặt hàng đã phụ trách. Danh sách sắp xếp giảm dần theo cột tổng số lượng các đơn đặt hàng đã phụ trách. 
select top 5 e.EmployeeID, LastName + ' ' + FirstName as FullName, count(OrderID) as SoLuong
into Tim5NVGioi
from Employees e, Orders o
where e.EmployeeID = o.EmployeeID
group by e.EmployeeID , LastName +' ' +FirstName
order by 3 desc

select * from Tim5NVGioi

--3.	Tạo một query đặt tên là Tim10KhachHang (tìm 10 khách hàng). Khi chạy, query này sẽ tạo ra một table mới có tên 10KhachHang. 
--Bảng này liệt kê danh sách 10 khách hàng có nhiều đơn đặt hàng nhất. Các thông tin gồm: mã khách hàng, tên công ty, địa chỉ đầy đủ 
--(1 cột gồm địa chỉ, thành phố và quốc gia), và tổng số lượng các đơn đặt hàng đã đặt.
--Danh sách sắp xếp giảm dần theo cột tổng số lượng các đơn đặt hàng đã đặt. 

select top 10 c.CustomerID, c.CompanyName, c.Address , count(OrderID) as SoLuong
into Tim10KhachHang
from Customers c, Orders o
where c.CustomerID = o.CustomerID
group by c.CustomerID, c.CompanyName, c.Address
order by 4 desc

select * from Tim10KhachHang
--4.	Tạo một query đặt tên là TimTop5QGMuaHang (tìm top 5 quốc gia mua hàng). Khi chạy, query này sẽ tạo ra một table mới có tên Top5QGMuaHang.
--Bảng này liệt kê danh sách top 5 quốc gia có khách hàng mua nhiều sản phẩm nhất. Gợi ý:  (Count(ProductID). 

--select  top 5 c.Country, count(OrderID) as SLDH
--into TimTop5QuocGia
--from Customers c, Orders o
--where c.CustomerID= o.CustomerID
--group by c.Country
--order by 2 desc


select top 5 c.Country, count(p.ProductID) as SanPham
into TimTop5QuocGiaMuaNhieu
from [Order Details] od, Products p, Orders o, Customers c
where od.ProductID = p.ProductID  and od.OrderID = o.OrderID and o.CustomerID = c.CustomerID
group by c.Country
order by 2 desc

select * from TimTop5QuocGiaMuaNhieu
--delete TimTop5QuocGia
--5.	Tạo một query đặt tên là Tim5QGItMuaHang (tìm 5 quốc gia ít mua hàng). Khi chạy, query này sẽ tạo ra một table mới có tên NamQGItMuaHang. 
--Bảng này liệt kê danh sách 5 quốc gia có khách hàng mua ít sản phẩm nhất. Gợi ý: (Count(ProductID). 

select top 5 c.Country, count(p.ProductID) as SanPham
into Tim5QGItMua
from [Order Details] od, Products p, Orders o, Customers c
where od.ProductID = p.ProductID  and od.OrderID = o.OrderID and o.CustomerID = c.CustomerID
group by c.Country
order by 2 

select * from Tim5QGItMua

--1.	Tạo một Append Query đặt tên là Them1LoaiSPa. Khi chạy query mới này thì ta thêm một record vào table Categories. Thông tin thêm vào là: 
--	   	CategoryName: Văn phòng phẩm 
--	   	Description: Sách, vở, giấy, bút, mực 
--Mở bảng Categories để xem các thay đổi sau khi ta chạy query. 

insert into Categories(CategoryName, Description)
values(N'VanPhongPham', N'sach,vo,giay,but,muc')

select * from Categories

--4.	Hãy tạo một query đặt tên là ThemMotNhanVien (thêm một nhân viên). Khi chạy, query này sẽ thêm một record vào table Employees với các thông tin cá nhân của các anh chị.
insert into Employees(LastName, FirstName, Title, TitleOfCourtesy,BirthDate,Address,City,Country, HomePhone)
values('Le','Tung','Student','Mr.', 07/10/2005,'Quan 7', 'HCMC', 'Viet Nam', 0965838224)

select * from Employees

--1.	Hãy tạo một query đặt tên là SuaTenQuocGia1 (sửa tên quốc gia) để khi chạy query này sẽ sửa lại tên quốc gia trong bảng CUSTOMERS: “USA” sửa thành “Mỹ”. 
--Tên các quốc gia khác vẫn giữ nguyên. 
select * into KH from Customers 

update KH
set Country = N'Mỹ'
where Country = 'USA'

select * from KH
where Country = N'Mỹ'

--2.	Hãy tạo một query đặt tên là SuaTenQuocGia2 (sửa tên quốc gia) để khi chạy query này sẽ sửa lại tên quốc gia 
--trong bảng CUSTOMERS: “Germany” sửa thành “Đức” và “France” sửa thành “Pháp”. Tên các quốc gia khác vẫn giữ nguyên. 

select * into KH2 from Customers 

update KH2
set Country = (case 
	when Country = 'Germany' then 'Duc'
	else 'Phap'
end)	
where Country in('Germany','France')

select * from KH2
--6.	Hãy tạo một query đặt tên là SuaPostalCode (sửa mã bưu điện) để khi chạy query này sẽ sửa mã bưu điện của các khách hàng 
--Germany: sửa 2 số đầu thành 18. Mã bưu điện của các khách hàng quốc gia khác giữ nguyên. 

select * into KH3 from Customers

update KH3 
set PostalCode ='18' + right(PostalCode, len(PostalCode)-2)
where Country = 'Germany'

select * from Customers where Country = 'Germany'
select * from KH3 where Country = 'Germany'


--1.	Hãy tạo một query đặt tên là ThongKeSPTheoNam (thống kê sản phẩm theo năm). Khi chạy, query sẽ hỏi năm bắt đầu thống kê, năm kết thúc thống kê sau đó lập một danh sách trong đó: 
--Các hàng là tên các sản phẩm, các cột là lần lượt các năm liên tiếp trong khoảng các năm vừa nhập, giá trị trong các ô là số lượng sản phẩm đã bán được

select ProductName, [1996],[1997],[1998]
from ( 
		select p.ProductName, year(OrderDate) 'Nam',sum(Quantity) 'SL'
		from Products p, [Order Details] od , Orders o
		where p.ProductID = od.ProductID and 
			od.OrderID = o.OrderID and year(OrderDate) between 1996 and 1998
		group by p.ProductName, year(OrderDate) 
) A
pivot(
	sum(SL) for Nam in ([1996],[1997],[1998])
)B


--2.	Hãy tạo một query đặt tên là ThongKeSPTheoThang (thống kê sản phẩm theo tháng). Khi chạy, query sẽ hỏi tháng bắt đầu thống kê, tháng kết thúc thống kê sau đó lập một danh sách trong đó:
--Các hàng là tên các sản phẩm, các cột là lần lượt các tháng liên tiếp trong khoảng các tháng vừa nhập của năm 1997, giá trị trong các ô là số lượng sản phẩm đã bán được. 
 
 select CompanyName, [1],[2],[3],[4], 
 'SUM' = round(isnull([1],0) + isnull([2],0) + isnull([3],0) + isnull([4],0),2)
 from  
 ( select CompanyName, UnitPrice *Quantity *(1-Discount) as triGia,
				datepart(q,OrderDate) as 'Quy'
		 from Customers c, Orders o, [Order Details] od
		 where c.CustomerID = o.CustomerID and od.OrderID = o.OrderID 
		 and year (OrderDate) = 1997 ) a
pivot (
	sum(triGia) for Quy in([1],[2],[3],[4])
) b
--1.	Hãy tạo một query đặt tên là ThongKeSPTheoNam (thống kê sản phẩm theo năm). Khi chạy, query sẽ hỏi năm bắt đầu thống kê, năm kết thúc thống kê sau đó lập một danh sách trong đó:
--Các hàng là tên các sản phẩm, các cột là lần lượt các năm liên tiếp trong khoảng các năm vừa nhập, giá trị trong các ô là số lượng sản phẩm đã bán được. 
select ProductName, [1996],[1997],[1998]
from ( 
		select p.ProductName, year(OrderDate) 'Nam',sum(Quantity) 'SL'
		from Products p, [Order Details] od , Orders o
		where p.ProductID = od.ProductID and 
			od.OrderID = o.OrderID and year(OrderDate) between 1996 and 1998
		group by p.ProductName, year(OrderDate) 
) A
pivot(
	sum(SL) for Nam in ([1996],[1997],[1998])
)B	

--5.	Tạo query crosstab thống kê doanh số của từng khách hàng của UK theo từng quý trong năm 1995. Kết quả có dạng:
--(trong đó doanh số = UnitPrice*Quantity) 
 select CompanyName ,isnull([1],0) Q1, isnull([2],0) Q2, isnull([3],0) Q3, isnull([4],0) Q4,
 isnull([1],0) + isnull([2],0) + isnull([3],0) + isnull([4],0) as TongCong
 from  
 ( select CompanyName, round(od.UnitPrice *od.Quantity,1) as doanhSo,
				datepart(qq,OrderDate) as 'Quy'
		 from Customers c, Orders o, [Order Details] od
		 where c.CustomerID = o.CustomerID and od.OrderID = o.OrderID 
		 and year(OrderDate) = 1997 and  c.Country = 'UK'
) a
pivot (
	sum(doanhSo) for Quy in([1],[2],[3],[4])
) b

--6.	Tạo query crostab thống kê doanh số của của từng nhóm hàng (Category Name) theo từng quý trong một năm nào đó. 
--Kết quả có dạng (thí dụ nhập năm 1995): 

select CategoryName, [1] Q1,[2] Q2,[3] Q3,[4] Q4, isnull([1],0) + isnull([2],0) + isnull([3],0) + isnull([4],0) as TongCong
from (
	select CategoryName, DATEPART(q,OrderDate) as quy, round(od.Quantity*od.UnitPrice*(1-Discount),0) as DoanhSo
	from Categories c, Products p, Orders o, [Order Details] od
	where c.CategoryID = p.CategoryID and
		p.ProductID = od.ProductID and
		o.OrderID = od.OrderID and
		year(OrderDate) = 1997
)A
pivot (
	sum(DoanhSo) for quy in([1],[2],[3],[4])
<<<<<<< HEAD
)B
=======
)B
>>>>>>> a711a5c3eb91ec067fea53ebe6f111dd22fe6714
