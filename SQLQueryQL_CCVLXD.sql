﻿CREATE DATABASE CUNGCAP_VLXD
USE CUNGCAP_VLXD

------------------------ĐẠI LÝ----------------------
GO
CREATE TABLE DaiLy(
	MaDL varchar(10) PRIMARY KEY,
	DaiLy nvarchar(100) NOT NULL,
	DIACHI nvarchar(100) NOT NULL,
	SoDT varchar(15) NOT NULL,
)

----------------------VẬT LIỆU-----------

GO
CREATE TABLE VatLieu(
	MAVL varchar(10) PRIMARY KEY,
	TENVL nvarchar(100) NOT NULL,
	DVT nvarchar(15),
	SOLUONG int NOT NULL,
	DONGIAVL int NOT NULL,
)
ALTER TABLE VatLieu ADD CONSTRAINT CK_SoLuong CHECK (SOLUONG > 0);

-------------------------NHÂN VIÊN------------------------

GO
CREATE TABLE NhanVien(
	MANV varchar(10) PRIMARY KEY,
	HoTen nvarchar(100) NOT NULL,
	DIACHI nvarchar(100),
	NGAYSINH date DEFAULT CONVERT (DATE, SYSDATETIME()),
	LUONG float NOT NULL,
	MADL varchar(10) NOT NULL,
	FOREIGN KEY (MADL) REFERENCES DaiLy(MADL) ON DELETE CASCADE,
)

------------------------KHO---------

GO
CREATE TABLE Kho(
	MAKHO varchar(10) PRIMARY KEY,
	TENKHO nvarchar(100) NOT NULL,
	DIACHI nvarchar(100) NOT NULL,
	MADL varchar(10) NOT NULL,
	FOREIGN KEY (MADL) REFERENCES DaiLy(MADL) ON DELETE CASCADE,
)

--------------------------------NHẬP HÀNG----------------------
GO
CREATE TABLE NhapHang(
	MaDNH varchar(10) PRIMARY KEY,
	NGAY date DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	MANV varchar(10) NOT NULL,
	MAKHO varchar(10) NOT NULL,
	FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
	FOREIGN KEY (MAKHO) REFERENCES KHO(MAKHO),
)

-------------------------------CHI TIẾT PHIẾU NHẬP--------------------
GO
CREATE TABLE CTPNH(
	MaDNH varchar(10) NOT NULL,
	MAVL varchar(10) NOT NULL,
	SOLUONG int NOT NULL,
	DONGIA int NOT NULL,
	PRIMARY KEY (MADNH, MAVL),
	FOREIGN KEY (MaDNH) REFERENCES NHAPHANG(MaDNH),
	FOREIGN KEY (MAVL) REFERENCES VATLIEU(MAVL),
)
ALTER TABLE dbo.CTPNH ADD CONSTRAINT CK_SoLuong_CTPNH CHECK (SOLUONG > 0);
ALTER TABLE dbo.CTPNH ADD CONSTRAINT CK_Dongia_CTPNH CHECK (DONGIA > 0);
---------------------------KHÁCH HÀNG------------------
GO
CREATE TABLE KhachHang (
	MAKH varchar(10)  PRIMARY KEY,
	TENKH nvarchar(100) NOT NULL,
	SoDT varchar(15) NOT NULL,
	DiaChi nvarchar(100) NOT NULL,
) 

-----------------------MUA HÀNG----------------------------
GO
CREATE TABLE MuaHang(
	MAPMH varchar(10) PRIMARY KEY,
	NGAY date DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	MAKH varchar(10)  NOT NULL,
	MANV varchar(10) NOT NULL,
	MAKHO varchar(10) NOT NULL,
	FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
	FOREIGN KEY (MAKHO) REFERENCES KHO(MAKHO),
	FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
)

-------------------------CHI TIẾT PHIẾU MUA----------
GO
CREATE TABLE CTPMH(
	MAPMH varchar(10) NOT NULL,
	MAVL varchar(10) NOT NULL,
	SOLUONG int NOT NULL,
	DONGIA int NOT NULL,
	PRIMARY KEY (MAPMH, MAVL),
	FOREIGN KEY (MAPMH) REFERENCES MuaHang(MAPMH),
	FOREIGN KEY (MAVL) REFERENCES VATLIEU(MAVL),
)
ALTER TABLE dbo.CTPMH ADD CONSTRAINT CK_SoLuong_CTPMH CHECK (SOLUONG > 0);
ALTER TABLE dbo.CTPMH ADD CONSTRAINT CK_Dongia_CTPMH CHECK (DONGIA > 0);

---------
use CUNGCAP_VLXD
GO
SELECT *
FROM DBO.VATLIEU
---------------
GO
SELECT *
FROM DBO.DAILY
--------------------
GO
SELECT *
FROM DBO.NHANVIEN
------------------
GO
SELECT *
FROM DBO.KHO
----------------
GO
SELECT *
FROM DBO.KHACHHANG
--------------------
GO
SELECT *
FROM DBO.MUAHANG
--------------------
GO
SELECT *
FROM DBO.NHAPHANG
--------------------
GO
SELECT *
FROM DBO.CTPMH
--------------------
GO
SELECT *
FROM DBO.CTPNH
--------------------

-----------------------------------------------

CREATE FUNCTION [dbo].[CheckMaNhanVien] (@MADL VARCHAR(10), @MANV VARCHAR(10))
RETURNS BIT
AS
BEGIN
	DECLARE @CHECK_MANV VARCHAR(10)
	SET @CHECK_MANV = 'NV'+@MADL
	
	IF (@MANV LIKE @CHECK_MANV +'%') RETURN 1
	RETURN 0;
END
SELECT * FROM sys.objects WHERE type_desc = 'SQL_SCALAR_FUNCTION' AND name = 'CheckMaNhanVien'
--sp_helptext 'ten_ham'
SELECT [dbo].[CheckMaNhanVien]('DL1', 'NVDL2003')



CREATE TRIGGER [dbo].[TR_NHANVIEN]
ON [dbo].[NHANVIEN]
AFTER INSERT, UPDATE
AS 

DECLARE @MADL VARCHAR(10)
DECLARE @MANV VARCHAR(10)
DECLARE @SO INT
SET @SO = (SELECT COUNT(MaDL) FROM DaiLy)
SET @MANV = (SELECT MANV FROM inserted)
IF  @SO > 1 
BEGIN
	DECLARE @MA VARCHAR(10)
	SET @MA = CONCAT('NVDL', @SO)
	IF (@MANV LIKE 'NVDL%' and @MANV < @MA)
	BEGIN
		PRINT N'THÀNH CÔNG'
	END
	ELSE 
		BEGIN
			PRINT N'THẤT BẠI, YÊU CẦU NHẬP MÃ NHÂN VIÊN Ở ĐẠI LÝ 1 BẮT ĐẦU BẰNG: NVDL VÀ NHỎ HON MÃ'+ @MA
		END
END

ELSE
	SET @MADL = (SELECT DaiLy.MaDL FROM DaiLy)
	
	IF @MADL ='DL1'
	BEGIN
		IF (@MANV LIKE 'NVDL1%')
			BEGIN
				PRINT N'THÀNH CÔNG'
			END
		ELSE 
			BEGIN 
				PRINT N'THẤT BẠI, YÊU CẦU NHẬP MÃ NHÂN VIÊN Ở ĐẠI LÝ 1 BẮT ĐẦU BẰNG: NVDL1'
				ROLLBACK TRAN
			END
	END
	----DL2
	ELSE IF @MADL ='DL2'
	BEGIN
		IF (@MANV LIKE 'NVDL2%')
			BEGIN
				PRINT N'THÀNH CÔNG'
			END
		ELSE 
			BEGIN 
				PRINT N'THẤT BẠI, YÊU CẦU NHẬP MÃ NHÂN VIÊN Ở ĐẠI LÝ 1 BẮT ĐẦU BẰNG: NVDL2'
				ROLLBACK TRAN
			END
	END
	----DL3
	ELSE IF @MADL ='DL2'
	BEGIN
		IF (@MANV LIKE 'NVDL1%')
			BEGIN
				PRINT N'THÀNH CÔNG'
			END
		ELSE 
			BEGIN 
				PRINT N'THẤT BẠI, YÊU CẦU NHẬP MÃ NHÂN VIÊN Ở ĐẠI LÝ 1 BẮT ĐẦU BẰNG: NVDL1'
				ROLLBACK TRAN
			END
	END
	----DL4
	ELSE IF @MADL ='DL4'
	BEGIN
		IF (@MANV LIKE 'NVDL4%')
			BEGIN
				PRINT N'THÀNH CÔNG'
			END
		ELSE 
			BEGIN 
				PRINT N'THẤT BẠI, YÊU CẦU NHẬP MÃ NHÂN VIÊN Ở ĐẠI LÝ 1 BẮT ĐẦU BẰNG: NVDL1'
				ROLLBACK TRAN
			END
	END
	---
	ELSE IF @MADL ='DL2'
	BEGIN
		IF (@MANV LIKE 'NVDL1%')
			BEGIN
				PRINT N'THÀNH CÔNG'
			END
		ELSE 
			BEGIN 
				PRINT N'THẤT BẠI, YÊU CẦU NHẬP MÃ NHÂN VIÊN Ở ĐẠI LÝ 1 BẮT ĐẦU BẰNG: NVDL1'
				ROLLBACK TRAN
			END
	END
	ELSE IF @MADL ='DL2'
	BEGIN
		IF (@MANV LIKE 'NVDL1%')
			BEGIN
				PRINT N'THÀNH CÔNG'
			END
		ELSE 
			BEGIN 
				PRINT N'THẤT BẠI, YÊU CẦU NHẬP MÃ NHÂN VIÊN Ở ĐẠI LÝ 1 BẮT ĐẦU BẰNG: NVDL1'
				ROLLBACK TRAN
			END
	END
END
-------------------------
--Tạo stored procedure "sp_thongke_doanhthu_khuvuc"
CREATE PROCEDURE sp_thongke_doanhthu_khuvuc
AS
BEGIN
--Truy vấn dữ liệu từ server 1
DECLARE @sql1 NVARCHAR(MAX) = '
SELECT dl.DIACHI, SUM(ctpmh.SOLUONG * ctpmh.DONGIA) AS DOANHTHU
FROM link1.DatabaseName.dbo.MuaHang mh
INNER JOIN link1.DatabaseName.dbo.CTPMH ctpmh ON mh.MAPMH = ctpmh.MAPMH
INNER JOIN link1.DatabaseName.dbo.VatLieu vl ON ctpmh.MAVL = vl.MAVL
INNER JOIN link1.DatabaseName.dbo.Kho kho ON mh.MAKHO = kho.MAKHO
INNER JOIN link1.DatabaseName.dbo.DaiLy dl ON kho.MADL = dl.MADL
GROUP BY dl.DIACHI
';
--Truy vấn dữ liệu từ server 2
DECLARE @sql2 NVARCHAR(MAX) = '
SELECT dl.DIACHI, SUM(ctpn.SOLUONG * ctpn.DONGIA) AS DOANHTHU
FROM link2.DatabaseName.dbo.NhapHang nh
INNER JOIN link2.DatabaseName.dbo.CTPNH ctpn ON nh.MaDNH = ctpn.MaDNH
INNER JOIN link2.DatabaseName.dbo.VatLieu vl ON ctpn.MAVL = vl.MAVL
INNER JOIN link2.DatabaseName.dbo.Kho kho ON nh.MAKHO = kho.MAKHO
INNER JOIN link2.DatabaseName.dbo.DaiLy dl ON kho.MADL = dl.MADL
GROUP BY dl.DIACHI
';

--Kết hợp kết quả từ hai server
DECLARE @sql NVARCHAR(MAX) = '
SELECT DIACHI, SUM(DOANHTHU) AS DOANHTHU
FROM (
' + @sql1 + '
UNION ALL
' + @sql2 + '
) T
GROUP BY DIACHI
';

--Thực thi truy vấn và trả về kết quả
EXECUTE sp_executesql @sql;
end

USE CUNGCAP_VLXD
GO

select Kho.MAKHO, MAVL, SUM(CTPNH.SOLUONG)
from DaiLy AS D
JOIN Kho ON Kho.MADL = D.MaDL
JOIN NhapHang AS NH ON NH.MAKHO = Kho.MAKHO
JOIN CTPNH ON CTPNH.MaDNH = NH.MaDNH
WHERE D.MaDL = 'DL1'
GROUP BY Kho.MAKHO, MAVL

select Kho.MAKHO, MAVL, SUM(CTPMH.SOLUONG)
from DaiLy AS D
JOIN Kho ON Kho.MADL = D.MaDL
JOIN MuaHang AS MH ON MH.MAKHO = Kho.MAKHO
JOIN CTPMH ON CTPMH.MaPMH = MH.MAPMH
WHERE D.MaDL = 'DL1'
GROUP BY Kho.MAKHO, MAVL

SELECT KQ.DIFFERENCE
FROM (
SELECT Q1.MAKHO, Q1.MAVL, Q1.SUM_CTPNH - Q2.SUM_CTPMH AS DIFFERENCE
FROM
  (SELECT Kho.MAKHO, MAVL, SUM(CTPNH.SOLUONG) AS SUM_CTPNH
  FROM DaiLy AS D
  JOIN Kho ON Kho.MADL = D.MaDL
  JOIN NhapHang AS NH ON NH.MAKHO = Kho.MAKHO
  JOIN CTPNH ON CTPNH.MaDNH = NH.MaDNH
  WHERE D.MaDL = 'DL1'
  GROUP BY Kho.MAKHO, MAVL) AS Q1
JOIN
  (SELECT Kho.MAKHO, MAVL, SUM(CTPMH.SOLUONG) AS SUM_CTPMH
  FROM DaiLy AS D
  JOIN Kho ON Kho.MADL = D.MaDL
  JOIN MuaHang AS MH ON MH.MAKHO = Kho.MAKHO
  JOIN CTPMH ON CTPMH.MaPMH = MH.MAPMH
  WHERE D.MaDL = 'DL1'
  GROUP BY Kho.MAKHO, MAVL) AS Q2
ON Q1.MAKHO = Q2.MAKHO AND Q1.MAVL = Q2.MAVL
) AS KQ

USE CUNGCAP_VLXD
------------HÀM KIỂM TRA SỐ LƯỢNG SẢN PHẨM CÒN LẠI TRONG KHO
GO
CREATE FUNCTION [dbo].[SumSLVattuofKho] (@MAKHO VARCHAR(10), @MAVL VARCHAR(10), @MADL VARCHAR(10))
RETURNS INT
AS
BEGIN
	DECLARE @SUMSLKHO INT = 0
	SET @SUMSLKHO = (SELECT Q1.SUM_CTPNH - Q2.SUM_CTPMH AS DIFFERENCE
				FROM
				  (SELECT Kho.MAKHO, MAVL, SUM(CTPNH.SOLUONG) AS SUM_CTPNH
				  FROM DaiLy AS D
				  JOIN Kho ON Kho.MADL = D.MaDL
				  JOIN NhapHang AS NH ON NH.MAKHO = Kho.MAKHO
				  JOIN CTPNH ON CTPNH.MaDNH = NH.MaDNH
				  WHERE D.MaDL = @MADL
				  GROUP BY Kho.MAKHO, MAVL) AS Q1
				JOIN
				  (SELECT Kho.MAKHO, MAVL, SUM(CTPMH.SOLUONG) AS SUM_CTPMH
				  FROM DaiLy AS D
				  JOIN Kho ON Kho.MADL = D.MaDL
				  JOIN MuaHang AS MH ON MH.MAKHO = Kho.MAKHO
				  JOIN CTPMH ON CTPMH.MaPMH = MH.MAPMH
				  WHERE D.MaDL = @MADL
				  GROUP BY Kho.MAKHO, MAVL) AS Q2
				ON Q1.MAKHO = Q2.MAKHO AND Q1.MAVL = Q2.MAVL
				WHERE Q1.MAKHO = @MAKHO AND Q1.MAVL = @MAVL)
	RETURN @SUMSLKHO;
END
------ test
SELECT [dbo].[SumSLVattuofKho]('KDL1001', 'VL009', 'DL1')
-----------------TRAN
GO
SET XACT_ABORT ON;
DECLARE @CHECKSUM INT;
DECLARE @SUMSLKHO INT;
DECLARE @MADL VARCHAR(10);
DECLARE @MAKHO VARCHAR(10);
DECLARE @MAVL VARCHAR(10);
---------------
DECLARE @MAKH VARCHAR(10);
DECLARE @SOLUONGMUA INT;
SET @MAKH = 'KH004'
SET @SOLUONGMUA = 6
------------
SET @MAKHO = 'KDL1001'
SET @MAVL = 'VL001'
SET @MADL = 'DL1'

BEGIN TRY
	BEGIN TRAN
		
		DECLARE @MAPM VARCHAR(10); SET @MAPM ='PMH007';
		INSERT [dbo].[MuaHang] ([MAPMH], [NGAY], [MAKH], [MANV], [MAKHO]) VALUES (@MAPM, '2023/02/26', @MAKH, 'NVDL1001', @MAKHO)
		--DECLARE @i INT = 1;
		--WHILE (@i <= 2)
		--BEGIN
			SET @SUMSLKHO = [dbo].[SumSLVattuofKho](@MAKHO, @MAVL, @MADL); -- HÀM KIỂM TRA SỐ LƯỢNG SẢN PHẨM CỦA 1 VẬT LIỆU CÒN LẠI TRONG KHO
			SET @CHECKSUM = @SUMSLKHO - @SOLUONGMUA;
			IF (@CHECKSUM < 0) THROW 50001, N'Số lượng sản phẩm không đủ.', 1; 
			INSERT [dbo].[CTPMH] ([MAPMH], [MAVL], [SOLUONG], [DONGIA]) VALUES (@MAPM, @MAVL, @SOLUONGMUA, 1)
			--SET @i = @i + 1;
		--END
	PRINT(N'THÀNH CÔNG!')	
	COMMIT TRAN
END TRY
BEGIN CATCH
	PRINT(N'Lỗi!');
	PRINT ERROR_MESSAGE();
	ROLLBACK TRAN
END CATCH
GO

select * from CTPMH