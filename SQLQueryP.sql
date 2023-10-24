create database DBphone
Use DBphone
create table Phone(
	id int IDENTITY(1,1) PRIMARY KEY,
	[name] nvarchar(255) not null,
	[date] date DEFAULT CONVERT (DATE, SYSDATETIME()) not null,
	brand nvarchar(max) not null,
	sold int not null,
)
insert into Phone([name], [date], [brand], [sold]) values(N'Iphone', '10/02/2002', N'đep', 1)
insert into Phone([name], [date], [brand], [sold]) values(N'Iphone nuber', '10/02/2002', N'đep', 0)
select * 
from Phone
WHERE [name] = 'iPhone' and id <> -1
select * from phone where name= 'iphone' and id <> 8