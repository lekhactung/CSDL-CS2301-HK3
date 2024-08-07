USE [master]
GO
/****** Object:  Database [QLCTY]    Script Date: 24/10/2022 3:18:07 PM ******/
CREATE DATABASE [QLCTY]
 
GO
ALTER DATABASE [QLCTY] SET COMPATIBILITY_LEVEL = 150
GO


USE [QLCTY]
GO
/****** Object:  Table [dbo].[DuAn]    Script Date: 24/10/2022 3:18:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DuAn](
	[MaDA] [char](10) NOT NULL,
	[TenDA] [nvarchar](50) NULL,
	[NgayDKBD] [date] NULL,
	[NgayDKKT] [date] NULL,
	[NgayBD] [date] NULL,
	[NgayKT] [date] NULL,
	[GhiChu] [nvarchar](50) NULL,
 CONSTRAINT [PK_DuAn] PRIMARY KEY CLUSTERED 
(
	[MaDA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 24/10/2022 3:18:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [int] NOT NULL,
	[HoNV] [nvarchar](20) NULL,
	[TenNV] [nvarchar](50) NULL,
	[BangCap] [nchar](10) NULL,
	[NamSinh] [datetime] NULL,
	[DiaChi] [nvarchar](50) NULL,
	[CV] [char](10) NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NVThamGiaDA]    Script Date: 24/10/2022 3:18:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NVThamGiaDA](
	[MaNV] [int] NOT NULL,
	[MaDA] [char](10) NOT NULL,
	[NgayBD] [date] NOT NULL,
	[NgayKT] [date] NULL,
	[NV] [nvarchar](50) NULL,
	[DanhGia] [nvarchar](50) NULL,
 CONSTRAINT [PK_NVThamGiaDA] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC,
	[MaDA] ASC,
	[NgayBD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NVThamGiaDA]  WITH CHECK ADD  CONSTRAINT [FK_NVThamGiaDA_DuAn] FOREIGN KEY([MaDA])
REFERENCES [dbo].[DuAn] ([MaDA])
GO
ALTER TABLE [dbo].[NVThamGiaDA] CHECK CONSTRAINT [FK_NVThamGiaDA_DuAn]
GO
ALTER TABLE [dbo].[NVThamGiaDA]  WITH CHECK ADD  CONSTRAINT [FK_NVThamGiaDA_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[NVThamGiaDA] CHECK CONSTRAINT [FK_NVThamGiaDA_NhanVien]
GO
USE [master]
GO
ALTER DATABASE [QLCTY] SET  READ_WRITE 
GO
