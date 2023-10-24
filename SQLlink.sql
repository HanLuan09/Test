USE CUNGCAP_VLXD

GO 
SELECT * FROM LINKtoDUONG.CUNGCAP_VLXD.DBO.NHANVIEN
------------LINK ĐẾN A TÍNH---------
GO
use master EXEC sp_addlinkedserver 
@server='LINKtoTINH', 
@srvproduct='', 
@provider='SQLOLEDB', 
@provstr = 'DRIVER={SQL Server};SERVER=ANHTINH\TINH_CSDLPT_N4;UID=HTKN;PWD=123;' 
------------LINK ĐẾN LUÂN---------
GO
use master EXEC sp_addlinkedserver 
@server='LINKtoLUAN', 
@srvproduct='', 
@provider='SQLOLEDB', 
@provstr = 'DRIVER={SQL Server};SERVER=DAO\CSDLPT_N4;UID=HTKN;PWD=123;' 
------------LINK ĐẾN HẢI---------
GO
use master EXEC sp_addlinkedserver 
@server='LINKtoHAI', 
@srvproduct='', 
@provider='SQLOLEDB', 
@provstr = 'DRIVER={SQL Server};SERVER=COWHAI\HAI_N4_CSDLPT;UID=HTKN;PWD=123;'

------------LINK ĐẾN DƯƠNG---------
GO
use master EXEC sp_addlinkedserver 
@server='LINKtoDUONG', 
@srvproduct='', 
@provider='SQLOLEDB', 
@provstr = 'DRIVER={SQL Server};SERVER=KUDO\CSDLPT_N4;UID=HTKN;PWD=123;'
------------LINK ĐẾN DÁNG---------
GO
use master EXEC sp_addlinkedserver 
@server='LINKtoDANG', 
@srvproduct='', 
@provider='SQLOLEDB', 
@provstr = 'DRIVER={SQL Server};SERVER=DESKTOP-346OC0A\DANG_CSDLPT_N4;UID=HTKN;PWD=123;'
------------LINK ĐẾN TÂM---------
GO
use master EXEC sp_addlinkedserver 
@server='LINKtoTAM', 
@srvproduct='', 
@provider='SQLOLEDB', 
@provstr = 'DRIVER={SQL Server};SERVER=WINDOWS-10\TAM_CSDLPT_N4;UID=HTKN;PWD=123;'
------------LINK ĐẾN TRANG---------
GO
use master EXEC sp_addlinkedserver 
@server='LINKtoTRANG', 
@srvproduct='', 
@provider='SQLOLEDB', 
@provstr = 'DRIVER={SQL Server};SERVER=LAPTOP-ICR54HNA\CSDLPT;UID=HTKN;PWD=123;'
------------LINK ĐẾN HỘI---------
GO
use master EXEC sp_addlinkedserver 
@server='LINKtoHOI', 
@srvproduct='', 
@provider='SQLOLEDB', 
@provstr = 'DRIVER={SQL Server};SERVER=DESKTOP-R4G81A4\HOI_CSDLPT_N4;UID=HTKN;PWD=123;'

------------LINK ĐẾN QUỐC ANH---------
GO
use master EXEC sp_addlinkedserver 
@server='LINKtoANH', 
@srvproduct='', 
@provider='SQLOLEDB', 
@provstr = 'DRIVER={SQL Server};SERVER=LAPTOP-VA1R9VFQ\CSDLPT_N4;UID=HTKN;PWD=123;'
