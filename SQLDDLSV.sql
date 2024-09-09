
--Khoa(MãKhoa(Char,8), TênKhoa(NVarchar,20, not null), NgàyThànhLập(DateTime), NộiDungĐàoTạo(NVarchar, 200), GhiChú(NVarchar, max) )


--Lớp(MãLớp(Char, 8), TênLớp(NVarchar, 20, not null), KhóaHọc(Char, 4), GVCN(NVarchar, 50), MãKhoa(Char, 8), GhiChú(NVarchar, max) )

--MônHọc(MãMH(int), TênMH(NVarchar,20, not null), NộiDungMH(NVarchar, 200), MãKhoa(Char, 8), SốTínChỉ(int), SốTíết(int), GhiChú(NVarchar, max) )
--SinhViên(MãSV(Char, 10), HọSV(NVarchar, 50, not null),TênSV(NVarchar, 20, not null), GiớiTính(NVarchar, 4), NgàySinh(DateTime), QuêQuán(NVarchar, 50), ĐịaChỉ(NVarchar, 100), MãLớp(Char, 8), GhiChú(NVarchar, max) )


--Học(MãSV(Char, 10), MãMH(int), NgàyĐăngKý(Date), 
--NgàyThi(Date), ĐiểmTrungBình(decimal(8,2)), GhiChú(NvarChar(Max)) ) 



--Tạo khóa ngoại



--6.	Tạo query tên ThêmCộtSoCMND, viết lệnh SQL để thêm cột SốCMND (char, 9) vào bảng SinhViên.

--7.	Tạo query tên ThêmCộtDTDD, viết lệnh SQL để thêm cột ĐiệnThọaiDiĐộng (char, 10) vào bảng SinhViên.

--8.	Tạo query tên SửaCộtDTDD, viết lệnh SQL để sửa thiết kế cột ĐiệnThọaiDiĐộng thành (char, 11) của bảng SinhViên.

--9.	Tạo query tên XóaCộtDTDD, viết lệnh SQL để xoá cột ĐiệnThọaiDiĐộng của bảng SinhViên.

--10.	Viết câu lệnh tạo ràng buộc sau trong bảng Hoc: điểm của sinh viên phải nằm trong khoảng từ 0 đến 10.




--11.	Viết câu lệnh tạo ràng buộc sau trong bảng Hoc: Ngày thi phải sau ngày hiện tại và ngày đăng ký có giá trị mặc định là ngày hiện tại


--12.	Viết câu lệnh tạo ràng buộc sau trong bảng Sinh viên: Số CMND không được phép trùng

--CÂU LỆNH DDL
--ALTER TABLE
--	ADD
--	ALTER COLUMN
--	DROP COLUMN
	
--	ADD CONSTRAINT 
--	DROP CONSTRAINT 




--Lấy tên các ràng buộc
Select  SysObjects.[Name] As [Constraint Name] ,
        Tab.[Name] as [Table Name],
        Col.[Name] As [Column Name]
From SysObjects Inner Join 
	(Select [Name],[ID] From SysObjects) As Tab
	On Tab.[ID] = Sysobjects.[Parent_Obj] 
	Inner Join sysconstraints On sysconstraints.Constid = Sysobjects.[ID] 
	Inner Join SysColumns Col On Col.[ColID] = sysconstraints.[ColID] And Col.[ID] = Tab.[ID]
order by [Tab].[Name]
 
--Lấy tên các Proceduce
SELECT name, 
       type
  FROM dbo.sysobjects
 WHERE (type = 'P')
 
 --cẤU TRÚC ĐỀ THI GIỮA KỲ
 /*
 2 PHẦN: TẠO BẢNG CÂU TRUY VẤN
 1 TẠO BẢNG (2Đ) dùng CÂU LỆNH SQL)
 2 VIẾT CÂU TRUY VẤN (8Đ): TRÊN CSDL CÓ SÃN:
	2Đ RÀNG BUỘC (CHECK, DEFAULT, UNIQUE)
	1Đ CÁC LỆNH (INSERT, UPDATE, DELETE)
	5Đ CÁC CÂU SELECT
 */