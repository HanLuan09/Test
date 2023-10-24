﻿

USE CUNGCAP_VLXD
GO
SET XACT_ABORT ON
DECLARE @SLNHAP INT = 100, @MAVL VARCHAR(10), @MAPN VARCHAR(10) = 'MNHDL1004', @MANV VARCHAR(10), @MAKHO VARCHAR(10) ='KDL1001'
SET @MANV = (SELECT TOP 1 NV.MANV
	FROM NhanVien AS NV
	JOIN DaiLy AS DL ON DL.MaDL = NV.MADL
	JOIN KHO ON KHO.MADL = DL.MaDL
	WHERE KHO.MAKHO = @MAKHO)
BEGIN TRY
	BEGIN TRAN
		INSERT INTO NhapHang([MaDNH], [NGAY], [MANV], [MAKHO]) VALUES (@MAPN, GETDATE(), @MANV, @MAKHO)
		DECLARE @SPNHAP INT = (SELECT COUNT(MAVL) FROM VatLieu WHERE DVT =N'VIÊN')
		DECLARE @I INT = 0
		WHILE(@I < @SPNHAP) 
			BEGIN
				SET @MAVL = (SELECT VL.MAVL
					FROM VatLieu AS VL
					WHERE VL.DVT =N'VIÊN'
					ORDER BY VL.MAVL
					OFFSET @I ROWS
					FETCH NEXT 1 ROWS ONLY)
				INSERT INTO CTPNH([MaDNH], [MAVL], [SOLUONG],[DONGIA]) VALUES(@MAPN, @MAVL, @SLNHAP, 1)
				UPDATE VatLieu SET SOLUONG = SOLUONG - @SLNHAP WHERE MAVL = @MAVL
				SET @I = @I +1
			END
	PRINT('YES')
	COMMIT TRAN
END TRY
BEGIN CATCH
	PRINT('NO')
	ROLLBACK TRAN
END CATCH


