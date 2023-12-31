﻿USE [CUNGCAP_VLXD]
GO
CREATE TRIGGER [dbo].[TR_NHANVIEN]
ON [dbo].[NhanVien]
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
			PRINT N'THẤT BẠI, YÊU CẦU NHẬP MÃ NHÂN VIÊN Ở ĐẠI LÝ 1 BẮT ĐẦU BẰNG: NVDL VÀ NHỎ HON'+ @MA
			ROLLBACK TRAN
		END
END
ELSE
BEGIN
	SET @MADL = (SELECT DaiLy.MaDL FROM DaiLy)
	
	IF ([dbo].[CheckMaNhanVien](@MADL, @MANV)=1)
		BEGIN
			PRINT N'THÀNH CÔNG'
		END
	ELSE 
		BEGIN 
			PRINT N'THẤT BẠI, YÊU CẦU NHẬP MÃ NHÂN VIÊN Ở ĐẠI LÝ BẮT ĐẦU BẰNG: NV'+@MADL
			ROLLBACK TRAN
		END
END

