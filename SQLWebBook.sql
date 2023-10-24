CREATE DATABASE WebBook
USE WebBook
GO
-------------------DANH MỤC------------
CREATE TABLE Category(
	CateID INT IDENTITY(1,1) PRIMARY KEY,
	NameC NVARCHAR(255) UNIQUE NOT NULL,
)

--------------Sản phẩm--------------
GO
CREATE TABLE Book(
	idB INT IDENTITY(1,1) PRIMARY KEY,
	nameB NVARCHAR(max) NOT NULL,
	imageB varchar(max) NOT NULL,
	title nvarchar(max) NOT NULL,---mô tả
	author nvarchar(255) NOT NULL, --- tác giả
	releaseDate Date DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	pages int not null,
	CateId INT NOT NULL,
	FOREIGN KEY (CateID) REFERENCES Category(CateID) ON DELETE CASCADE,
)ALTER TABLE Book 
ADD [status] int;
---------------KHACH HANG------------
CREATE TABLE Account(
	IdA INT IDENTITY(1,1) PRIMARY KEY,
	imageA varchar(max),
	Username NVARCHAR(255) UNIQUE NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	[password] VARCHAR(255) NOT NULL,
	isAdmin INT NOT NULL,
)
--------địa chỉ--------
GO
CREATE TABLE [Address](
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdA INT NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	Phone CHAR(10) NOT NULL,
	[Address] NVARCHAR(255) NOT NULL,
	FOREIGN KEY (IdA) REFERENCES Account(IdA) ON DELETE CASCADE,
)
------------đặt hàng--------------
GO
CREATE TABLE [Order](
	IdO int IDENTITY(1,1) PRIMARY KEY,
	CreatedDate date DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	IdA int NOT NULL,
	FOREIGN KEY (IdA) REFERENCES Account(IdA)
)
insert into dbo.[Order]([ido], [CreatedDate], [ida], [Status]) values()
------------ Chi tiết đơn đặt------
GO
CREATE TABLE OrderDetails(
	IdO int NOT NULL,
	IdB int NOT NULL,
	Amount int NOT NULL,
	[Status] int NOT NULL,
	PRIMARY KEY (IdO, IdB),
	FOREIGN KEY (IdO) REFERENCES [Order](IdO),
	FOREIGN KEY (IdB) REFERENCES Book(IdB),
)
update book set [status] =1
insert into dbo.OrderDetails([ido], [idb], [Amount], [Price]) values()
-----------Đánh giá---------
GO
CREATE TABLE BookRating(
	IdA int NOT NULL,
	IdB int NOT NULL,
	IdO int NOT NULL,
	Rating int,
	comment NVARCHAR(max),
	dateRating date DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	PRIMARY KEY (IdA, IdB, idO),
	FOREIGN KEY (IdA) REFERENCES Account(IdA),
	FOREIGN KEY (IdB) REFERENCES Book(IdB),
	FOREIGN KEY (IdO) REFERENCES dbo.[Order](IdO),
)


-----------------insert----------
-------DANH MỤC-----------
GO 
INSERT INTO DBO.Category([NameC]) VALUES(N'Văn học nghệ thuật')
INSERT INTO DBO.Category([NameC]) VALUES(N'Truyện, tiểu thuyết')
INSERT INTO DBO.Category([NameC]) VALUES(N'Sách thiếu nhi')
INSERT INTO DBO.Category([NameC]) VALUES(N'Sách giáo khoa')
INSERT INTO DBO.Category([NameC]) VALUES(N'Chính trị – pháp luật')
INSERT INTO DBO.Category([NameC]) VALUES(N'Khoa học viễn tưởng')
INSERT INTO DBO.Category([NameC]) VALUES(N'Sách truyền cảm hứng')
UPDATE dbo.Category SET NameC=N'Sách học ngoại ngữ' WHERE CateID = 6
UPDATE dbo.Category SET NameC=N'Truyện tranh' WHERE CateID = 5
------------Books------------
GO
--IdB=1
	 
INSERT INTO DBO.Book([NameB], [ImageB], [title], [author], [releaseDate], [pages], [CateID]) 
VALUES(N'Cây Cam Ngọt Của Tôi', 'image_caycamngotcuatoi.jpg'
,N'Mở đầu bằng những thanh âm trong sáng và kết thúc lắng lại trong những nốt trầm hoài niệm, Cây cam ngọt của tôi khiến ta nhận ra vẻ đẹp thực sự của cuộc sống đến từ những điều giản dị như bông hoa trắng của cái cây sau nhà, và rằng cuộc đời thật khốn khổ nếu thiếu đi lòng yêu thương và niềm trắc ẩn. Cuốn sách kinh điển này bởi thế không ngừng khiến trái tim người đọc khắp thế giới thổn thức, kể từ khi ra mắt lần đầu năm 1968 tại Brazil.'
,N'José Mauro de Vasconcelos', '03/04/2018', 82, 2)
--IdB=2
INSERT INTO DBO.Book([NameB], [ImageB], [title], [author], [releaseDate], [pages], [CateID]) 
VALUES(N'Nhà Giả Kim (Tái Bản 2020)', 'image_nhagiakim.jpg'
,N'Tiểu thuyết Nhà giả kim của Paulo Coelho như một câu chuyện cổ tích giản dị, nhân ái, giàu chất thơ, thấm đẫm những minh triết huyền bí của phương Đông. Trong lần xuất bản đầu tiên tại Brazil vào năm 1988, sách chỉ bán được 900 bản. Nhưng, với số phận đặc biệt của cuốn sách dành cho toàn nhân loại, vượt ra ngoài biên giới quốc gia, Nhà giả kim đã làm rung động hàng triệu tâm hồn, trở thành một trong những cuốn sách bán chạy nhất mọi thời đại, và có thể làm thay đổi cuộc đời người đọc. “Nhưng nhà luyện kim đan không quan tâm mấy đến những điều ấy. Ông đã từng thấy nhiều người đến rồi đi, trong khi ốc đảo và sa mạc vẫn là ốc đảo và sa mạc. Ông đã thấy vua chúa và kẻ ăn xin đi qua biển cát này, cái biển cát thường xuyên thay hình đổi dạng vì gió thổi nhưng vẫn mãi mãi là biển cát mà ông đã biết từ thuở nhỏ. Tuy vậy, tự đáy lòng mình, ông không thể không cảm thấy vui trước hạnh phúc của mỗi người lữ khách, sau bao ngày chỉ có cát vàng với trời xanh nay được thấy chà là xanh tươi hiện ra trước mắt. ‘Có thể Thượng đế tạo ra sa mạc chỉ để cho con người biết quý trọng cây chà là,’ ông nghĩ.”- Trích Nhà giả kim'
,N'Paulo Coelho' , '06/10/2020', 82, 2)
--IdB=3
INSERT INTO DBO.Book([NameB], [ImageB], [title], [author], [releaseDate], [pages], [CateID])
VALUES(N'Ghi Chép Pháp Y - Những Cái Chết Bí Ẩn', 'image_ghichepphapy.jpg'
,N'“Ghi chép pháp y - Những cái chết bí ẩn” là cuốn sách nằm trong hệ liệt với “Pháp y Tần Minh” - bộ tiểu thuyết nổi đình đám của xứ Trung đã được chuyển thể thành series phim. Cuốn sách tổng hợp những vụ án có thật, được viết bởi bác sĩ pháp y Lưu Hiểu Huy - người có 15 năm kinh nghiệm và từng mổ xẻ hơn 800 tử thi.'
,N'Lưu Hiểu Huy' , '02/08/2010', 82, 2)
--IdB=4
INSERT INTO DBO.Book([NameB], [ImageB], [title], [author], [releaseDate], [pages], [CateID]) 
VALUES(N'Những Người Hàng Xóm', 'image_nhungnguoihangxom.jpg'
,N'Câu chuyện đi theo lời kể của một anh chàng mới lấy vợ, chuẩn bị đi làm và có ý thích viết văn. Anh chàng yêu vợ theo cách của mình, khen ngợi sùng bái người yêu cũng theo cách của mình, nhưng nhìn cuộc đời theo cách sống của những người hàng xóm. Sống trong tình yêu của vợ đầy mùi thơm và nhiều vị ngọt. Chứng kiến tình yêu của anh cảnh sát với cô bạn gái ngành y; mối tình thứ hai của người phụ nữ tốt bụng phát thanh viên ngôn ngữ ký hiệu. Và được chiêm nghiệm trong tình yêu đắm đuối mỗi ngày của ông họa sĩ già thương nhớ người vợ xinh đẹp-người mẫu, nàng thơ của ông.'
,N'Nguyễn Nhật Ánh' , '12/10/2020', 82, 2)
--IdB=5
INSERT INTO DBO.Book([NameB], [ImageB], [title], [author], [releaseDate], [pages], [CateID])
VALUES(N'Bước Chậm Lại Giữa Thế Gian Vội Vã (Tái Bản 2018)', 'image_buoc_cham_lai_giua_the_gian_voi_va.jpg'
,N'Chen vai thích cánh để có một chỗ bám trên xe buýt giờ đi làm, nhích từng xentimét bánh xe trên đường lúc tan sở, quay cuồng với thi cử và tiến độ công việc, lu bù vướng mắc trong những mối quan hệ cả thân lẫn sơ… bạn có luôn cảm thấy thế gian xung quanh mình đang xoay chuyển quá vội vàng?
Nếu có thể, hãy tạm dừng một bước. Để tự hỏi, là do thế gian này vội vàng hay do chính tâm trí bạn đang quá bận rộn? Để cầm cuốn sách nhỏ dung dị mà lắng đọng này lên, chậm rãi lật giở từng trang, thong thả khám phá những điều mà chỉ khi bước chậm lại mới có thể thấu rõ: về các mối quan hệ, về chính bản thân mình, về những trăn trở trước cuộc đời và nhân thế, về bao điều lý trí rất hiểu nhưng trái tim chưa cách nào nghe theo…'
,N'Hae Min' , '05/04/2016', 80, 2)
--IdB=6
INSERT INTO DBO.Book([NameB], [ImageB], [title], [author], [releaseDate], [pages], [CateID])
VALUES(N'Như Đóa Hoa Sương - Tặng Kèm Chữ Ký Tác Giả', 'image_nhudoahoasuong.jpg'
,N'Có những tác phẩm đưa thông điệp và tư tưởng của nó đi theo hàng triệu độc giả trong hàng trăm năm, cũng có những tác phẩm chỉ cần chạm vào chính người viết thôi là đã hoàn thành sứ mệnh của nó rồi. Mà thực ra, phần lớn sách trên thế giới này nằm ở dạng thứ hai, cũng tức là nếu chúng vô tình có thể khơi gợi trong bạn sự chú tâm, rung động và đồng cảm thì thật tuyệt vời, phải không? Khi gửi tác phẩm này, Gào nói với tôi rằng phần lớn nội dung của Như Đoá Hoa Sương đã được hoàn thiện trong giai đoạn Covid lock-down. Có lẽ khi hầu hết các cánh cửa đóng lại, thì cánh cửa vốn vẫn đóng kín trong tâm hồn chúng ta mới lại có cơ hội được mở ra. Phía sau nó lại không phải những giấc mơ tung cánh, mà lại là từng tấm kính ước vọng sụp đổ. Qua những mảnh vỡ đã vụn rơi dưới sàn lạnh buốt ấy soi chiếu lại thế giới quan, thấy những điều lớn lao là vô nghĩa, và những điều có vẻ tầm thường lại là hình thái rõ ràng nhất của sự rung động.'
,N'Gào' , '10/08/2019', 68, 2)
--IdB=7
INSERT INTO DBO.Book([NameB], [ImageB], [title], [author], [releaseDate], [pages], [CateID])
VALUES(N'', ''
,N''
,N'', '', 0,  0)
--IdB=8
INSERT INTO DBO.Book([NameB], [ImageB], [title], [author], [releaseDate], [pages], [CateID])
VALUES(N'', ''
,N''
,N'', '', 0, 0)

---------Tài khoản-------------
use WebBook
GO
INSERT INTO DBO.Account([imageA], [Username], [email], [Password], [isAdmin]) VALUES('anhuserwebbook.png', N'Admin', 'ngongan52@gmail.com', '1234567', 1)
INSERT INTO DBO.Account([imageA],[Username], [email], [Password], [isAdmin]) VALUES('anhuserwebbook.png', N'LuanHan', 'luan43@gmail.com', '1234566', 0)

select * from Account where (Username = '' or email= 'ngongan52@gmail.com') and [Password] = '1234567'



--------đặt hàng------
GO
INSERT INTO DBO.[Order]([CreatedDate], [IdA]) VALUES('03/03/2023', 1)
INSERT INTO DBO.[Order]([CreatedDate], [IdA]) VALUES('10/04/2023', 2)
--------chi tiết đơn đặt------------

GO
INSERT INTO DBO.OrderDetails([IdO], [IdB], [Amount], [Status]) VALUES(1, 2, 3,  0)
INSERT INTO DBO.OrderDetails([IdO], [IdB], [Amount], [Status]) VALUES(1, 3, 3,  0)
INSERT INTO DBO.OrderDetails([IdO], [IdB], [Amount], [Status]) VALUES(2, 2, 8,  0)
INSERT INTO DBO.OrderDetails([IdO], [IdB], [Amount], [Status]) VALUES(2, 5, 4, 0)
INSERT INTO DBO.OrderDetails([IdO], [IdB], [Amount],  [Status]) VALUES(2, 3, 5, 0)

INSERT INTO BookRating([idA], [idB], [rating], [comment]) values(1, 2, 4, N'Hàng chất lượng.')
INSERT INTO BookRating([idA], [idB], [rating], [comment]) values(1, 3, 5, N'Hàng chất lượng.')
----rating
SELECT b.*, SUM(od.Amount) AS TotalSold, AVG(br.rating) AS AverageRating, COUNT(br.rating) AS TotalRating
FROM Book b
LEFT JOIN OrderDetails od ON b.IdB = od.IdB
LEFT JOIN BookRating br ON b.IdB = br.IdB
--where CateID > 2
GROUP BY b.NameB, b.IdB, b.releaseDate, b.pages, b.author, b.imageB, b.title, b.CateId
ORDER BY SUM(od.Amount) DESC

--------------
select BR.*, A.imageA, A.Username
from BookRating AS BR
LEFT JOIN Account AS A ON A.IdA = BR.IdA
WHERE BR.IdB = 3


WITH Ratings AS (
SELECT rating FROM (VALUES (5), (4), (3), (2), (1)) AS R(rating)
)
SELECT Ratings.rating, COUNT(BookRating.rating) AS Count
FROM Ratings
LEFT JOIN BOOKRating ON Ratings.rating = BOOKRating.rating AND BOOKRating.IdB = 3
GROUP BY Ratings.rating;












SELECT Book.IdB AS 'IdB', 
	   Book.NameB AS 'nameB',
	   Book.author AS 'author',
       Category.NameC AS 'nameC',
	   --Book.Amount AS 'pAmount',
	   Book.releaseDate AS 'releaseDate',
	   Book.pages AS 'pages',
       SUM(OrderDetails.Amount) AS 'sumPrice'
FROM Book
INNER JOIN Category ON Book.CateID = Category.CateID
LEFT JOIN OrderDetails ON Book.IdB = OrderDetails.IdB
--where Category.NameC like N'%chó%' or  Product.NameP like N'%mèo%'
GROUP BY Book.NameB, Book.IdB, Category.NameC, Book.releaseDate, Book.pages, Book.author


SELECT Book.IdB AS 'IdB', 
	   Book.NameB AS 'nameB',
	   Book.author AS 'author',
       Category.NameC AS 'nameC',
	   --Book.Amount AS 'pAmount',
	   Book.releaseDate AS 'releaseDate',
	   Book.pages AS 'pages',
       SUM(OrderDetails.Amount) AS 'sumPrice'
FROM Book
INNER JOIN Category ON Book.CateID = Category.CateID
LEFT JOIN OrderDetails ON Book.IdB = OrderDetails.IdB
where Category.NameC like N'%như%' or  Book.NameB like N'%như%' or Book.author like N'%như%'
GROUP BY Book.NameB, Book.IdB, Category.NameC, Book.releaseDate, Book.pages, Book.author


select * from Book

select * from Category
EXCEPT
select * from Category where CateID = 1
SELECT *
FROM Category
ORDER BY 
	CASE 
		WHEN CateID = 5 THEN 0
		ELSE 1 
	END, CateID

SELECT TOP 4
	   Book. *,
       SUM(OrderDetails.Amount) AS 'sumPrice'
FROM Book
LEFT JOIN OrderDetails ON Book.IdB = OrderDetails.IdB
GROUP BY Book.NameB, Book.IdB, Book.releaseDate, Book.pages, Book.author, Book.imageB, Book.title, Book.CateId
order by sumPrice DESC
SELECT B.*
FROM Book B
JOIN Category C ON B.CateId = C.CateID
WHERE B.nameB LIKE N'%g%'
   OR C.NameC LIKE N'%g%'
   OR B.author LIKE N'%cay%'

SELECT Book.*, SUM(OrderDetails.Amount) AS TotalSold
FROM Book
LEFT JOIN OrderDetails ON Book.idB = OrderDetails.IdB
GROUP BY Book.idB, Book.nameB, Book.imageB, Book.title, Book.author, Book.releaseDate, Book.pages, Book.CateId
ORDER BY TotalSold DESC;
SELECT *
FROM Book
ORDER BY Book.idB DESC;

SELECT b.*
FROM Book b
LEFT JOIN (
    SELECT IdB, AVG(Evaluate) as avg_evaluate
    FROM BookValue
    GROUP BY IdB
) bv ON b.IdB = bv.IdB
ORDER BY bv.avg_evaluate DESC

USE WebBook
GO
SELECT B.IdB, O.idO, B.NameB, O.CreatedDate, OD.[Status]
FROM Book AS B
INNER JOIN OrderDetails AS OD ON B.IdB = OD.IdB
INNER JOIN [Order] AS O ON OD.IdO = O.IdO
WHERE O.IdA = 2



select * from [Order] where IdA = 2

Use WebBook
Go
SELECT B.idB, B.NameB, B.author, OrderDetails.IdO, OrderDetails.Amount, OrderDetails.Price
FROM Book AS B
INNER JOIN OrderDetails ON b.IdB = OrderDetails.IdB
WHERE OrderDetails.IdO = 2 and OrderDetails.IdB = 2


use WebBook
go
select * from Book where nameB = N'Như Đóa Hoa Sương - Tặng Kèm Chữ Ký Tác Giả' and author = N'Gào' and idB <> 5
SELECT dbo.Book.idB,
dbo.Book.nameB,
dbo.Book.imageB,
dbo.Book.title,
dbo.Book.author,
dbo.Book.releaseDate,
dbo.Book.pages,
dbo.Book.CateId,
FROM dbo.Book

CREATE TABLE Book(
	idB INT IDENTITY(1,1) PRIMARY KEY,
	nameB NVARCHAR(max) NOT NULL,
	imageB varchar(max) NOT NULL,
	title nvarchar(max) NOT NULL,---mô tả
	author nvarchar(255) NOT NULL, --- tác giả
	releaseDate Date DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	pages int not null,
	CateId INT NOT NULL,

	