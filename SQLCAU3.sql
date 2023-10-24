



USE CUNGCAP_VLXD
GO
SET XACT_ABORT ON
DECLARE @Ma varchar(10)='VL005', @sl int=1000
Begin Try
	Begin Tran
	--Kiem tra ma vat lieu da co trong bang vat lieu hay chua. Neu co (update), neu khong(insert)
	If Exists (Select * from VatLieu Where MAVL = @Ma)
		Update VatLieu
		Set SOLUONG = SOLUONG + @sl
		Where MAVL = @Ma
	Else
		INSERT into dbo.VatLieu([MAVL], [TENVL],[DVT], [SOLUONG], [DONGIAVL]) VALUES (@Ma, 'Gỗ xây dựng ',NULL, @sl, 100000)
	Select * from VatLieu
	Commit Tran
End Try
Begin Catch
	ROLLBACK Tran
End CATCH
