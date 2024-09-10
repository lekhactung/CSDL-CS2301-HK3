﻿--1.	Viết tích Đề-các giữa 2 bảng Customers và Orders, nhận xét số hàng kết quả. Thêm điều kiện kết, nhận xét số hàng kết quả. 
--2.	Lập danh sách các Customer ở thành phố London hoặc ở nước Pháp (France). Danh sách gồm: Customer ID, Company Name, Contact Name, Address, City 
	select CustomerID, CompanyName,ContactName,Address,City
	from Customers 
	where City = 'London' or Country = 'France'
--3.	Lập danh sách các Customer là Sales Manager của nước Mỹ (USA) hoặc là Owner của Mexico. Danh sách gồm như trên, thêm cột Contact Title 
	select  CustomerID, CompanyName,ContactName,Address,City,ContactTitle
	from Customers
	where (ContactTitle ='Sales Manager' and Country='USA')  or (ContactTitle='Owner'and Country= 'Mexico')
--4.	Lập danh sách các Customer là Manager của nước Mỹ (USA) hoặc: không phải là Owner của Mexico. Danh sách gồm các fields như trên 
	select  CustomerID, CompanyName,ContactName,Address,City,ContactTitle
	from Customers
	where (ContactTitle like  '%Manager'  and Country='USA') or (not ContactTitle='Owner' and Country= 'Mexico')
--5.	Lập danh sách các Order có ngày đặt hàng trong 6 tháng đầu năm 1997. Danh sách gồm: Order ID, Order Date, Customer, Employee 
--trong đó Customer là Company Name của khách hàng, Employee lấy Last Name 
	set dateformat dmy
	select OrderID,OrderDate,CompanyName,LastName
	from Orders o,Customers c,Employees e
	where OrderDate between '1/1/1997' and '30/6/1997'
	and o.EmployeeID = e.EmployeeID and o.CustomerID = c.CustomerID
--6.	Lập danh sách các Order có ngày đặt hàng trong tháng 2 năm 1997. Danh sách gồm: Order ID, Order Date, CustomerID, EmployeeID.
	select OrderID,OrderDate,CustomerID,EmployeeID
	from Orders
	where MONTH(OrderDate) = 2 and YEAR(OrderDate)=1997
--7.	Danh sách các Order có Ship Country là UK do nhân viên có mã là 2 phụ trách trong năm 1997. Danh sách gồm:   Order ID, Order Date, Freight 
	select  OrderID,OrderDate,Freight
	from Orders o 
	where YEAR(OrderDate)= 1997  and ShipCountry = 'UK' and EmployeeID=2
--8.	Người ta muốn biết danh sách các sản phẩm có tên bắt đầu là Ch. Anh chi hãy lập danh sách này, gồm các cột: Product ID, Product Name.
	select ProductID,ProductName
	from Products
	where ProductName like 'Ch%'
--9.	Lập danh sách các sản phẩm không còn tiếp tục cung cấp nữa (trường Discontinued) và có số lượng tồn kho (trường Unit In stock) lớn hơn không.
--Danh sách gồm: Product ID, Unit Price, Unit In Stock.
	select ProductID, UnitPrice, UnitsInStock
	from Products 
	where Discontinued = 1 and UnitsInStock >0
--10.	Lập danh sách các khách hàng không thuộc nước Mỹ. Danh sách gồm: Company Name, Contact Name, Country, Phone, Fax 
	select CompanyName, ContactName, Country, Phone , Fax 
	from Customers
	where Country not like 'USA'
--11.	Lập danh sách các khách hàng không thuộc các nước Brazil, Italy, Spain, Venezuela và UK. Danh sách gồm: Company Name, Contact Name, Country, Phone, Fax 
	select CompanyName, ContactName, Country, Phone , Fax 
	from Customers
	where Country not in ( 'Brazil', 'Italy', 'Spain', 'Venezuela','UK')
--12.	Lập danh sách các đơn đặt hàng có Ship country là USA và có Freight > 300 hoặc các đơn có Ship Country là Argentina và Freight <5. Danh sách gồm: Order ID, Customer, Employee, Order date, Ship Country, Ship date, Freight 
	select o.OrderID,CompanyName,LastName,OrderDate,ShipCountry,ShippedDate,Freight
	from Orders o, Customers c, Employees e
	where o.CustomerID = c.CustomerID and
	o.EmployeeID = e.EmployeeID and
	((ShipCountry = 'USA' and Freight > 300) or (ShipCountry = 'Argentina' and Freight <5))
--13.	Lập danh sách các đơn đặt hàng có Ship country là USA và có Freight > 300 hoặc các đơn có Ship Country là Argentina và Freight <5. Danh sách gồm: Order ID, Customer, Employee, Order date, Ship Country, Ship date, Freight 
	select o.OrderID,CompanyName,LastName,OrderDate,ShipCountry,ShippedDate,Freight
	from Orders o, Customers c, Employees e
	where o.CustomerID = c.CustomerID and
	o.EmployeeID = e.EmployeeID and
	((ShipCountry = 'USA' and Freight > 300) or (ShipCountry = 'Argentina' and Freight <5))
--14.	Lập danh sách các đơn hàng trong tháng 4/97 gồm các thông tin sau: Order ID, Order Date, Customer, Employee, Freight, New-Freight trong đó New-Freight =110% Freight. 
	select o.OrderID,CompanyName,LastName,OrderDate,ShipCountry,ShippedDate,Freight,'New-Freight'=1.1*Freight
	from Orders o, Customers c, Employees e
	where o.CustomerID = c.CustomerID and
	o.EmployeeID = e.EmployeeID and
	(YEAR(OrderDate)=1997 and MONTH(OrderDate)=4)
--15.	Lập danh sách trị giá tồn kho các Product không còn tiếp tục cung cấp nữa (trường 
--Discontinued là Yes). Danh sách gồm: Product ID, Product Name, Supplier Name, 
--UnitPrice, 	UintsInStock, 	Total, 	Supplier 	Fax, 	trong 	đó 	Total 	= UnitPrice*UnitsInStock 
	select ProductID,ProductName,s.ContactName as SupplierName,UnitPrice,UnitsInStock,s.Fax
	from Products p, Suppliers s
	where p.Discontinued = '1' and s.SupplierID = p.SupplierID
--16.	Lập danh sách nhân viên (Table Employee) có hire date từ năm 1993 trở về trước. Danh sách gồm: Name, Hire date, Title, BirthDate, Home Phone,
--trong đó trường Name ghép từ các trường: TitleOfCourstesy, chữ đầu trường LastName và trường FirstName 
	select 'Name' =TitleOfCourtesy + LastName + FirstName ,HireDate,Title,BirthDate,HomePhone
	from Employees e
	where YEAR(HireDate) < 1993
--17.	Lập danh sách các Order có ngày đặt hàng trong tháng 4 hàng năm. Danh sách gồm: Order ID, Order Date, Customer, 
--Employee trong đó Customer là Company Name của khách hàng, Employee lấy Last Name 
	select OrderID, OrderDate, c.CompanyName as Customer, e.LastName
	from Orders o, Customers c, Employees e
	where month(OrderDate) =4  and
	o.CustomerID =  c.CustomerID and
	o.EmployeeID = e.EmployeeID
--18.	Lập danh sách các Order có ngày đặt hàng các năm chẳn. Danh sách gồm: Order ID, Order Date, Customer, 
--Employee trong đó Customer là Company Name của khách hàng, Employee lấy Last Name 
	select OrderID, OrderDate, c.CompanyName as Customer, e.LastName
	from Orders o, Customers c, Employees e
	where year(OrderDate)%2 =0  and
	o.CustomerID =  c.CustomerID and
	o.EmployeeID = e.EmployeeID
--19.	Lập danh sách các Order có ngày đặt hàng là 5, 13, 14, 23. Danh sách gồm: Order ID, Order Date, Customer, Employee 
--trong đó Customer là Company Name của khách hàng, Employee lấy Last Name 
	select OrderID, OrderDate, c.CompanyName as Customer, e.LastName
	from Orders o, Customers c, Employees e
	where (day(OrderDate)=5 or day(OrderDate)=13 or day(OrderDate)=14 or day(OrderDate)=23)  and
	o.CustomerID =  c.CustomerID and
	o.EmployeeID = e.EmployeeID
--20.	Người ta muốn có danh sách chi tiết các hoá đơn (Order Details) trong năm 1997. Danh sách gồm các thông tin: Order ID, ProductName, 
--Unit Price, Quantity, ThanhTien, Discount, TienGiamGia, TienPhaiTra trong đó: ThanhTien = UnitPrice*Quantity, TienGiamGia = ThanhTien *Discount,
--TienPhaiTra = ThanhTien – TienGiamGia 
	select o.OrderID , p.ProductName, od.UnitPrice, Quantity, od.UnitPrice*Quantity as ThanhTien, Discount,
	'TienGiamGia' =  od.UnitPrice*Quantity*Discount,'TienPhaiTra' = ( od.UnitPrice*Quantity) - (od.UnitPrice*Quantity*Discount)
	from [Order Details] od, Orders o, Products p
	where od.OrderID = o.OrderID and
	od.ProductID = p.ProductID and
	year(o.OrderDate) = 1997

--21.	Tương tự như câu 20 nhưng chỉ lấy các record có Discount >0 và có TienPhaiTra <50 
	select o.OrderID , p.ProductName, od.UnitPrice, Quantity, od.UnitPrice*Quantity as ThanhTien, Discount,
	'TienGiamGia' =  od.UnitPrice*Quantity*Discount,'TienPhaiTra' = ( od.UnitPrice*Quantity) - (od.UnitPrice*Quantity*Discount)
	from [Order Details] od, Orders o, Products p
	where od.OrderID = o.OrderID and
	od.ProductID = p.ProductID and
	Discount > 0 and
	(od.UnitPrice*Quantity) - (od.UnitPrice*Quantity*Discount) < 50 and
	year(o.OrderDate) = 1997
--22.	Từ Table Product, đếm số sản phẩm, đơn giá cao nhất, thấp nhất và đơn giá trung bình cuả tất cả sản phẩm 
	select count(ProductID) as 'Count', MAX(UnitPrice) as 'Max',MIN(UnitPrice) as 'MIN', avg(UnitPrice) as 'AVG'
	from Products
--23.	Như câu 22 nhưng được nhóm theo loại sản phẩm (Category ID) 
	select count(ProductID) as 'Count', MAX(UnitPrice) as 'Max',MIN(UnitPrice) as 'MIN', avg(UnitPrice) as 'AVG', CategoryID
	from Products
	group by CategoryID

	select count(ProductID) as 'Count', Max(UnitPrice) as 'Max', min(Unitprice) as ' Min', avg(UnitPrice) as 'AVG', CategoryID
	from Products
	group by CategoryID
	
--24.	Đếm số đơn đặt hàng cuả các Order có Ship Country là Belgium, Canada, UK 
	select count(OrderID) as 'Số đơn đặt hàng', ShipCountry
	from Orders
	where ShipCountry = 'Belgium' or ShipCountry ='Canada' or ShipCountry = 'UK'
	group by ShipCountry
--25.	Lập danh sách các loại sản phẩm có đơn giá trung bình lớn hơn 30 
	select CategoryName , round(AVG(UnitPrice),1) as 'Đơn giá trung bình'
	from Categories c, Products p
	where c.CategoryID = p.CategoryID 
	group by CategoryName
	having avg(UnitPrice) > 30
--26.	Tính đơn giá trung bình cuả các sản phẩm có đơn giá lớn hơn 30, nhóm theo loại sản phẩm 
	select CategoryName , AVG(UnitPrice) 'DGTB'
	from Categories c, Products p
	where c.CategoryID = p.CategoryID and UnitPrice>30
	group by CategoryName
--27.	Thiết kế query tính doanh số của từng loại sản phẩm (Category) trong năm 1996. Danh sách gồm 2 cột: 
--Category Name, Sales; trong đó SalesTotal = UnitPrice*Quantity*(1-Discount) 
	select CategoryName, 'Sale Total' = round(sum(od.UnitPrice * od.Quantity * (1-od.Discount)),1)
	from Categories c, [Order Details] od, Orders o, Products p
	where od.OrderID = o.OrderID and 
		od.ProductID = p.ProductID and
		p.CategoryID = c.CategoryID and 
		year(OrderDate)= 1996 
	group by CategoryName
--28.	Thiết kế query tính tỉ lệ tiền cước mua hàng (Freight) của từng khách hàng trong năm 1997. Danh sách gồm các cột:
--Company Name (của Customer), Freight, SalesTotal = UnitPrice * Quantity*(1-Discount), Percent= Freight/SalesTotal 
	select c.CompanyName, Freight, sum(od.UnitPrice * od.Quantity * (1-od.Discount)) as 'SaleTotal', 
	'Percent' = Freight/sum(od.UnitPrice * od.Quantity * (1-od.Discount))
	from Customers c, [Order Details] od, Orders o, Products p
	where c.CustomerID = o.CustomerID and 
		o.OrderID = od.OrderID 
		and od.ProductID = p.ProductID
		and year(OrderDate) = 1997
	group by CompanyName, Freight


--29.	Lập danh sách Customer có Company Name bắt đầu là 1 chữ nào đó được nhập từ bàn phím. Danh sách gồm:
--Customer ID, CompanyName, ContactName, Address, City, Country, Phone, Fax 
	declare @tenCTy nvarchar(40)
	set @tenCTy = 'c'

	select *
	from Customers 
	where CompanyName like @tenCTy + '%'
--30.	Lập danh sách các Order có Order Date trong 1 khoảng thời gian nào đó. Tham số nhập: “From date:” và “To:”. 
--Danh sách gồm: Order ID, Customer, ShipCountry, OrderDate 
	set dateformat dmy
	declare @NgayBD datetime, @NgayKT datetime
	set @NgayBD = '1/1/1997'
	set @NgayKT = '30/4/1997'

	select * 
	from Orders
	where OrderDate between @NgayBD and @NgayKT
--31.	Người ta muốn có danh sách các Order của một quốc gia nào đó của khách hàng trong một năm mua hàng nào đó được nhập từ bàn phím. 
--Anh chị hãy thực hiện Query này. Danh sách gồm các cột như trên. 
	set dateformat dmy
	declare @Nuoc nvarchar(15), @NamMua datetime
	set @nuoc ='UK'
	set @NamMua = 1996
	select * 
	from Orders
	where ShipCountry = @Nuoc and year(OrderDate) = @NamMua
--32.	Tạo danh sách các Product thuộc một loại nào đó khi nhập Category ID từ bàn phím. Danh sách gồm: Product Name, Unit Price, Supplier 
	declare @ID int 
	set @ID = 2
	select p.ProductName , p.UnitPrice, s.CompanyName as Supplier
	from Products p, Suppliers s, Categories c
	where p.CategoryID = c.CategoryID and
		p.SupplierID = s.SupplierID and
		p.CategoryID = @ID
--33.	Người ta muốn biết trong một ngày nào đó có số lượng đơn đặt hàng theo từng khách hàng cần phải hoàn tất hay không? (theo Required Date). 
--Anh Chị hãy tạo query để thực hiện điều này. Thí dụ nhập ngày 28/9/95 thì ra kết quả sau: 
	set dateformat dmy
	declare @Ngay datetime
	set @Ngay = '28/10/1997'
	select c.CompanyName, count(o.OrderID) as 'CountOrderID' 
	from Orders o, Customers c
	where day(RequiredDate)=day(@ngay) and month(RequiredDate)=month(@ngay) and year(RequiredDate) = year(@ngay) and
	o.CustomerID  = c.CustomerID
	group by c.CompanyName
--34.	Thông thường các khách hàng muốn biết thông tin về đơn hàng của họ đã đặt hàng vào một ngày nào đó. (Khách hàng sẽ báo tên công ty và ngày đặt hàng). 
--Thông tin gồm tất cả các cột của table Order. Anh chị hãy thiết kế query để thực hiện điều này. 
	set dateformat dmy
	declare @ngaydat datetime
	set @ngaydat = '28/10/1997'
	declare @CompanyName varchar(50)
	set @CompanyName = 'Piccolo und mehr'
	select * 
	from Customers c, [Order Details] od, Orders o
	where c.CustomerID = o.CustomerID 
		--and  day(RequiredDate)=day(@ngaydat) and month(RequiredDate)=month(@ngaydat) and year(RequiredDate) = year(@ngaydat) and
		and day(OrderDate) = 28 and month(OrderDate) = 10 and year(OrderDate) = 1997 and
		c.CompanyName = @CompanyName

--35.	Tương tự nhưng năm được nhập từ bàn phím; trong đó nếu không nhập năm mà chỉ Enter thì sẽ lấy năm hiện tại để tính. 
--36.	Người ta muốn biết trong một ngày nào đó (nếu chỉ Enter là ngày hiện tại) tổng số đơn đặt hàng và doanh số cuả các đơn hàng đó là bao nhiêu. Thí dụ nhập 7 thang 4 nam 1998 thì kết quả sẽ là: 
