
USE CUNGCAP_VLXD
GO 
SET XACT_ABORT ON
BEGIN Try
	Begin Tran
		declare @Ma varchar(10) = 'NVDL8003'
		declare @MaDL varchar(10)='DL3'
		INSERT into NhanVien(MANV, HoTen, LUONG, MADL, DIACHI) values ( @Ma, 'AN', 7000000, @MaDL, 'THANH XUAN')
		UPDATE DBO.NhanVien
		SET LUONG = LUONG * 1.2
		WHERE MADL = @MaDL;
		Select *from NhanVien WHERE MADL =@MaDL
	Commit Tran
End Try
Begin Catch
	ROLLBACK Tran
End CATCH