CREATE DATABASE jdbc_demo
USE jdbc_demo
GO
CREATE TABLE Book(
	bookcode int IDENTITY(1,1) PRIMARY KEY,
	title nvarchar(max) not null,
	author nvarchar(255),
	category nvarchar(255) not null,
	approved int 
)
go
insert into book([title], [author], [category], [approved]) values(N'Cây Cam Ngọt Của Tôi', N'José Mauro de Vasconcelos', N'Tiểu thuyết', 1)
insert into book([title], [author], [category], [approved]) values(N'Nhà Giả Kim', N'Paulo Coelho', N'Tiểu thuyết', 0)
insert into book([title], [author], [category], [approved]) values(N'Từng Có Người Yêu Tôi Như Sinh Mệnh', N'Thư Nghi', N'Ngôn tình', 1)
insert into book([title], [author], [category], [approved]) values(N'Bến Xe', N'Thương Thái Vi', N'Ngôn tình', 0)
select * from book where title = N'luan'
select * from book where title = N'luan' and bookcode <> -1