CREATE DATABASE SHOPPET
GO
USE SHOPPET
----------DANH MỤC-----------------
GO
CREATE TABLE Category(
	CateID INT IDENTITY(1,1) PRIMARY KEY,
	NameC NVARCHAR(255) UNIQUE NOT NULL,
)
--------------Sản phẩm--------------
GO
CREATE TABLE Product(
	IdP INT IDENTITY(1,1) PRIMARY KEY,
	NameP NVARCHAR(max) NOT NULL,
	ImageP varchar(max) NOT NULL,
	--Title nvarchar(255) NOT NULL,
	Describe nvarchar(max) NOT NULL,---mô tả
	Origin nvarchar(255) NOT NULL, --- nguồn gốc
	Amount int NOT NULL, --- số lượng
	Discount int not null, ---giamr giá
	Price INT NOT NULL, ---TÍNH TRÊN KÍCH THƯỚC NHỎ NHẤT
	CateID INT NOT NULL,
	FOREIGN KEY (CateID) REFERENCES Category(CateID) ON DELETE CASCADE,
)
ALTER TABLE product
ADD [status] int;
update OrderDetails set [status] =1
GO
CREATE TABLE Color(
	IdP INT NOT NULL,
	Color NVARCHAR(255) NOT NULL,
	Ratio int not null, ---tỉ lệ giá giữa các màu sắc
	PRIMARY KEY(IDP, COLOR),
	FOREIGN KEY (IdP) REFERENCES Product(IdP) ON DELETE CASCADE,
)
--------các kích thước của sản phẩm------
GO
CREATE TABLE Size(
	IdP INT NOT NULL,
	Size NVARCHAR(255) NOT NULL,
	PRIMARY KEY(IDP, size),
	Ratio int not null, ---tỉ lệ giá giữa các kích thước
	FOREIGN KEY (IdP) REFERENCES Product(IdP) ON DELETE CASCADE,
)
-----tài khoản-----------
GO
CREATE TABLE Account(
	IdA INT IDENTITY(1,1) PRIMARY KEY,
	imageA varchar(max),
	Username NVARCHAR(255) UNIQUE NOT NULL,
	[Password] VARCHAR(255) NOT NULL,
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
--ALTER TABLE [Order] ADD IdO AS 'MA' + FORMAT(IDENT_CURRENT('[Order]') + 1, 'D6')
CREATE TABLE OrderAdderss(
	IdO INT UNIQUE NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	Phone CHAR(10) NOT NULL,
	[Address] NVARCHAR(255) NOT NULL,
	FOREIGN KEY (IdO) REFERENCES dbo.[Order](IdO) ON DELETE CASCADE,
)
CREATE TABLE Payment(
	IdO INT NOT NULL,
	bankcode NVARCHAR(255),
	priceBank int NOT null,
	priceSum INT NOT null,
	OrderInfo NVARCHAR(255),
	[payDate] DATE DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	FOREIGN KEY (IdO) REFERENCES dbo.[Order](IdO) ON DELETE CASCADE,
)
------------ Chi tiết đơn đặt------
GO
CREATE TABLE OrderDetails(
	IdO int NOT NULL,
	IdP int NOT NULL,
	Amount int NOT NULL,
	Price int NOT NULL,
	[Status] int NOT NULL,
	PRIMARY KEY (IdO, IdP),
	FOREIGN KEY (IdO) REFERENCES [Order](IdO),
	FOREIGN KEY (IdP) REFERENCES Product(IdP),
)
----------dánh giá
GO
CREATE TABLE ProductRating(
	IdA int NOT NULL,
	IdP int NOT NULL,
	IdO int NOT NULL,
	rating int,
	comment nvarchar(max),
	dateRating date DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	PRIMARY KEY (IdA, IdP, IdO),
	FOREIGN KEY (IdA) REFERENCES Account(IdA),
	FOREIGN KEY (IdP) REFERENCES Product(IdP),
	FOREIGN KEY (IdO) REFERENCES dbo.[Order](IdO)
)
--ALTER TABLE ProductRating ADD comment Nvarchar(max);
--------------------------INSERT------------------------------
-------DANH MỤC-----------
GO 
INSERT INTO DBO.Category([NameC]) VALUES(N'Giống chó nuôi')
INSERT INTO DBO.Category([NameC]) VALUES(N'Giống mèo nuôi')
INSERT INTO DBO.Category([NameC]) VALUES(N'Thức ăn cho chó')
INSERT INTO DBO.Category([NameC]) VALUES(N'Đồ dùng cho chó')
INSERT INTO DBO.Category([NameC]) VALUES(N'Thức ăn cho mèo')
INSERT INTO DBO.Category([NameC]) VALUES(N'Đồ dùng cho mèo')
INSERT INTO DBO.Category([NameC]) VALUES(N'Dụng cụ y tế & thuốc')
INSERT INTO DBO.Category([NameC]) VALUES(N'Dụng cụ chăm sóc')

-------SẢN PHẨM--------
GO
--id 1
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Chó Corgi', 'cho-corgi.jpg', N'Có 2 giống Corgi xứ Wales là Cardigan & Pembroke, tên gọi giống theo địa danh chúng xuất hiện. Sự khác biệt nổi bật là cấu trúc xương, chiều dài cơ thể. Corgi Cardigan có kích thước lớn hơn so với Pembroke. Cardigan có màu sắc đa dạng hơn, nhưng màu trắng không được chiếm ưu thế. 
Cardgan Corgi mạnh mẽ, năng động, thông mình & khá điềm tĩnh. Trong khi đó Corgi Pembroke thấp lùn, thông minh, nhanh nhẹn với khả năng làm việc  cường độ cao ở các trang trại. Pembroke có đôi tai nhọn, phần đầu giống cáo với đuôi ngắn (hoặc được cắt từ nhỏ). Nếu không cắt, đuôi Pembroke thường xoăn cuộn, trong khi đuôi Cardigan thẳng hàng với cơ thể, to, dài (khoảng 30 cm) và không được cắt.'
, N'xứ Wales (vương quốc Anh)', 8, 0, 5000000, 1)
---id 2
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Thức ăn cho chó con cỡ vừa ROYAL CANIN Medium Puppy','thuc-an-cho-cho-con-royal-canin-medium-puppy1-768x768.jpg', N'Thức ăn cho chó con cỡ vừa ROYAL CANIN Medium Puppy dành cho chó con dưới 12 tháng tuổi. Sản phẩm được nghiên cứu để cung cấp dinh dưỡng theo nhu cầu thực tế của chó con. Duy trì sức đề kháng cho chó con: chất chống oxy hóa CELT. Hỗ trợ hệ tiêu hóa hoạt động ổn định: L.I.P, đường FOS. Cung cấp dinh dưỡng cho chó toàn diện: chế biến theo công thức cung cấp năng lượng cao.'
,N'Pháp',1000, 15, 250000, 3)

----id=3
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Súp thưởng cho chó tiêu hóa tốt INABA WANG Gastrointestinal Health','sup-thuong-cho-cho-tieu-hoa-tot-inaba-wang-gastrointestinal-health-768x768.jpg',
N'Súp thưởng cho chó tiêu hóa tốt INABA WANG Gastrointestinal Health chứa Fructo-oligosaccharides giúp phòng ngừa cho đường ruột và dạ dày của chó luôn khỏe mạnh. Sản phẩm không chứa chất bảo quản. Chó đặc biệt rất thích loại nước súp thưởng này.'
,N'Nhật Bản', 1000, 15,  40000, 3)
----id 4
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Súp thưởng cho chó vị thịt bò INABA Beef Flavor', 'sup-thuong-cho-cho-vi-thit-bo-inaba-beef-flavor-768x768.jpg',
N'Súp thưởng cho chó vị thịt bò INABA Beef Flavor với thành phần nguyên liệu chất lượng cao đã được say nhuyễn. Có thể thưởng cho chó ăn vặt trực tiếp hoặc trộn cùng với thức ăn khác. Sản phẩm không chứa chất bảo quản. Chó đặc biệt rất thích loại nước súp thưởng này.'
,N'Nhật Bản', 588, 10, 40000 , 3)
----id =5
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Súp thưởng cho chó chắc xương INABA WANG Joint Health', 'sup-thuong-cho-cho-chac-xuong-inaba-wang-joint-health-768x768.jpg', 
N'Súp thưởng cho chó chắc xương INABA WANG Joint Health được kết hợp bởi Glucosamine hydrochloride và Chondroitin sulfate natri giúp cho xương của chó luôn chắc khỏe. Sản phẩm không chứa chất bảo quản. Chó đặc biệt rất thích loại nước súp thưởng này.'
,N'Nhật Bản', 655 , 10, 40000, 3)
--id =6
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Súp ăn liền cho chó vị gà và khoai tây INABA WANG Chicken & Potatoes', 'sup-an-lien-cho-cho-vi-ga-va-khoai-tay-inaba-wang-chicken-potatoes-768x768.jpg', 
N'Súp ăn liền cho chó vị gà và khoai tây INABA WANG Chicken & Potatoes với thành phần hương vị hỗn hợp chất lượng cao đã được say nhuyễn. Có thể thưởng cho chó ăn vặt trực tiếp hoặc trộn cùng với thức ăn khác. Sản phẩm không chứa chất bảo quản. Chó đặc biệt rất thích loại nước súp thưởng này.'
,N'Nhật Bản', 432 , 10, 40000, 3)
--id =7
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Súp thưởng cho chó thơm miệng INABA WANG Oral Health', 'sup-thuong-cho-cho-thom-mieng-inaba-wang-oral-health-768x768.jpg', 
N'Súp thưởng cho chó chắc xương INABA WANG Joint Health với thành phần Polyphenol trong trà xanh gấp 5 lần sẽ giúp cho răng miệng của chó luôn sạch sẽ, ngăn ngừa sâu răng và hôi miệng.. Sản phẩm không chứa chất bảo quản. Chó đặc biệt rất thích loại nước súp thưởng này.'
,N'Nhật Bản', 566, 10, 40000, 3)
--id=8
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Bánh thưởng cho chó vị thịt bò VEGEBRAND Orgo Freshening Biscuit Bacon Beef', 'banh-thuong-cho-cho-vi-thit-bo-vegebrand-orgo-freshening-biscuit-bacon-beef-768x768.jpg', 
N'Bánh thưởng cho chó vị thịt bò VEGEBRAND Orgo Freshening Biscuit Bacon Beef có tác dụng làm sạch răng cho chó vị thịt bò. Sản phẩm có chứa các thành phần bạc hà tự nhiên kết hợp với hương vị thịt bò, có khả năng loại bỏ các vi khuẩn gây hôi miệng cho chú chó của bạn một cách nhanh chóng. Sản phẩm có thể kết hợp dùng để huấn luyện.'
,N'Châu Âu', 1000, 0, 25000 , 3)
--id=9
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Súp thưởng cho mèo vị cá hồi IRIS Salmon Soup', 'sup-thuong-cho-meo-vi-ca-hoi-iris-salmon-soup8-768x768.jpg', 
N'Súp thưởng cho mèo vị cá hồi IRIS Salmon Soup dành cho tất cả các giống mèo trên 3 tháng tuổi.'
,N'Nhật Bản', 899, 12, 60000, 5)
--id=10
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Thức ăn cho mèo CATIDEA Grain Free Natural Nutrition', 'thuc-an-cho-meo-grain-free-natural-nutrition-768x768.jpg', 
N'Thức ăn cho mèo CATIDEA Grain Free Natural Nutrition dành cho các giống mèo và các giai đoạn tuổi của chúng. Cung cấp các chất dinh dưỡng thiết yếu cần thiết cho mèo. Đảm bảo an toàn, không gây kích ứng da với những chú mèo nhạy cảm nhất. Cam kết mang đến cho mèo những thành phần dinh dưỡng tốt nhất. Thức ăn cho mèo CATIDEA Grain Free Natural Nutrition được chế biến theo công thức rất riêng. Các loại thịt có tác dụng cung cấp lượng Protein cần thiết và quan trọng. Tác động mạnh mẽ tới vận động của mèo, phát triển cơ và miễn dịch. Vị thảo dược đặc biệt kích thích tiêu hóa. Có tác dụng tích cực trong việc ngăn ngừa sỏi thận ở mèo. Giảm tối đa mùi của nước tiểu và phân. Ngoài ra, dầu ép cá hồi mang lại lượng Omega 3 và 6 cần thiết, tăng cường sức khỏe của da và lông. Chất xơ thúc đẩy bài tiết chất độc hại và đẩy các búi lông trong thành ruột ra ngoài cơ thể. Chắc chắc rằng đây là loại thức ăn rất cần thiết cho chú mèo của bạn.'
,N'Hàn Quốc', 430, 14, 285.000, 5)
--id=11
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Bánh thưởng cho chó vị thịt xông khói JERHIGH Bacon', 'banh-thuong-cho-cho-vi-thit-xong-khoi-jerhigh-bacon-768x768.jpg', 
N'Bánh thưởng cho chó vị thịt xông khói JERHIGH Bacon mang lại nguồn năng lượng mới cho tất cả các giống chó. Bánh thưởng cho chó vị thịt xông khói JERHIGH Bacon mang lại cho thú cưng nguồn năng lượng và dinh dưỡng để phát triển khỏe mạnh và toàn diện. Năng lượng Protein từ thịt gà giúp phát triển cơ bắp và hồi phục các mô. Cân bằng năng lượng cho các hoạt động trong ngày của cún cưng. Vitamin D3 giúp xương và răng chắc khỏe. Bảo vệ xương khớp trong quá trình vận động, tăng cường độ linh hoạt và dẻo dai. Vitamin B1, B5, B6 hỗ trợ tiêu hóa, phát triển não bộ. Giúp chú cún của bạn trở lên thông minh và nhanh nhẹn hơn. Tiếp thu các bài học huấn luyện nhanh chóng. Vitamin B1 giúp tăng cường hoạt động trao đổi chất với môi trường.'
,N'Châu Âu',134 , 0, 55000, 3)
--id=12
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Thức ăn cho chó trưởng thành PURINA PRO PLAN Medium Adult', 'thuc-an-cho-cho-truong-thanh-purina-pro-plan-medium-adult.jpg', 
N'Thức ăn cho chó trưởng thành PURINA PRO PLAN Medium Adult (Dry Dog Food) hoàn chỉnh vị thịt gà nguyên chất cho chó trưởng thành từ 12 tháng tuổi trở lên. Áp dụng cho các giống chó có vóc dáng vừa và trung bình khi trưởng thành nặng từ 10 đến 25kg. Thức ăn cho chó trưởng thành PURINA PRO PLAN Medium Adult với thành phần nhiều nhất trong sản phẩm là thịt gà thật Giúp phát triển thể trọng lý tưởng, kéo dài tuổi thọ chó. Thành phần Taurine hỗ trợ chức năng tim mạch. Prebiotics giúp cân bằng hệ vi sinh đường ruột. Cùng các khoáng chất, vitamin D và axit béo Omega-3 hỗ trợ sức khỏe răng, nướu. Nguyên liệu cao cấp giúp thú cưng hấp thu dưỡng chất tối ưu.'
,N'Anh', 98, 10, 420000, 3)
--id=13
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Thức ăn cho chó hạt mềm vị thịt bò JERHIGH Beef Recipe', 'thuc-an-cho-cho-hat-mem-vi-thit-bo-jerhigh-meat-as-meals-beef-recipe-768x768.jpg', 
N'Thức ăn cho chó hạt mềm vị thịt bò JERHIGH Beef Recipe (Meat As Meals) dành cho tất cả các giống chó từ bé đến trưởng thành. JERHIGH Beef Recipe mang lại cho thú cưng sự hưng phấn và ăn ngon hơn mỗi ngày. Các thành phần nguyên liệu được sản xuất dựa trên công thức đặc biệt. Giúp cân bằng dinh dưỡng cho vật nuôi. Bổ sung protein chất lượng cao duy trì năng lượng mỗi ngày. Omega 3 và 6 trong cá và các loại thảo mộc giúp bổ sung chất dinh dưỡng cho da và lông.'
,N'Việt Nam', 1233, 20, 300000, 3)
--id=14
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Thức ăn cho mèo mọi lứa tuổi CATIDEA Basic Meat Freeze Dried', 'thuc-an-cho-meo-catidea-basic-meat-freeze-dried-768x768.jpg', 
N'Thức ăn cho mèo mọi lứa tuổi CATIDEA Basic Meat Freeze Dried dành cho tất cả các giống mèo ở mọi lứa tuổi. Sản phẩm không chứa chất bảo quản. Sản phẩm được bổ sung thêm cá hồi, thịt gà và lòng đỏ trứng gà. Công thức hạt có chứa 43% Protein thô, 21% chất béo thô cung cấp dinh dưỡng cho mèo chuyên sâu.'
,N'Trung Quốc', 100, 18, 580000, 5)
--id=15
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Súp cho mèo CIAO Grilled Tuna vị cá ngừ nướng', 'soup-cho-meo-ciao-grilled-tuna-vi-ca-ngu-nuong-768x769.jpg', 
N'Soup cho mèo CIAO Grilled Tuna vị cá ngừ nướng liền kích thích vị giác tiềm ẩn của mèo, giúp mèo háu ăn hơn và cung cấp bổ sung thêm các dưỡng chất tốt nhất cho mèo. Sản phẩm là dạng súp thưởng cho mèo / pate cho mèo đã say nhuyễn để ăn vặt và bữa phụ. Có thể cho ăn tối thiểu 1 ngày 2 lần, mỗi lần khoảng 2 đến 3 túi. Hoặc điều chỉnh theo nhu cầu và hoạt động thực tế của mèo. Hạn sử dụng xem ở phía sau của bao bì.'
,N'Nhật Bản', 190, 25, 25000, 5)
--id=16
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Súp thưởng cho mèo vị cá thu IRIS Bonito Soup', 'sup-thuong-cho-meo-vi-ca-thu-iris-bonito-soup-768x768.jpg', 
N'Súp thưởng cho mèo vị cá thu IRIS Bonito Soup dành cho tất cả các giống mèo trên 3 tháng tuổi.'
,N'Nhật Bản', 120, 0, 20000, 5)
---id =17
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Súp thưởng cho mèo vị cá ngừ sốt táo CATIDEA Fairy Chef Sachet Tuna & Apple', 'sup-thuong-cho-meo-vi-ca-ngu-sot-tao-catidea-fairy-chef-sachet-tuna-apple-768x768.jpg', 
N'Súp thưởng cho mèo vị cá ngừ sốt táo CATIDEA Fairy Chef Sachet Tuna & Apple dành cho tất cả các giống mèo. Súp thưởng cho mèo vị cá ngừ sốt táo CATIDEA Fairy Chef Sachet Tuna & Apple bao gồm: cá ngừ, táo, dầu hướng dương, tinh bột sắn biến tính, nước ép cá ngừ. Thành phần phụ gia Guar gum, Fructooligosaccharides, Taurine, Vitamin E. Giá trị đảm bảo khi phân tích thành phần sản phẩm Protein thô > 6%, chất béo thô > 1%, xơ thô < 1%, tro thô < 3%, độ ẩm < 88%.'
,N'Nhật Bản', 110, 10, 25000, 5)
--id = 18
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Dầu xả cho chó mèo làm mượt lông JOYCE & DOLLS 102 Silky Coat Conditioner', 'dau-xa-cho-cho-meo-lam-muot-long-joyce-dolls-102-silky-coat-conditioner-768x768.jpg', 
N'Dầu xả cho chó mèo làm mượt lông JOYCE DOLLS 102 Silky Coat Conditioner sử dụng cho tất cả các giống chó mèo. Bao gồm chó Poodle, Pug, Phốc sóc, Alaska… Dầu xả cho chó mèo làm mượt lông JOYCE & DOLLS 102 Silky Coat Conditioner giúp cho bộ lông của thú cưng trở nên mềm mại hơn. Sản phẩm sữa tắm có chứa tảo lục chlorella và Moroccan glycerin và một loạt các vitamin tự nhiên. Được thêm vào trong thành phần để nuôi dưỡng lông và làn da nuôi dưỡng sâu bên trong. Giúp da được mịn màng và giữ ẩm lâu dài. Lông trở nên mượt hơn. Đặc biệt phù hợp với các giống chó mèo lông dài. Khi tắm không gây kích ứng da và dị ứng. Dầu gội dưỡng lông giúp bạn chăm sóc bộ lông và da của thú cưng luôn khỏe mạnh. Tránh sự xâm nhập của bụi bẩn, vi khuẩn và ký sinh trùng.'
,N'Hàn Quốc', 50, 10, 240000, 6)
--id = 19
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Sữa tắm cho chó khôi phục màu lông BBN Reddening Shampoo', 'sua-tam-cho-cho-khoi-phuc-mau-long-bbn-reddening-shampoo-768x768.jpg', 
N'Sữa tắm cho chó khôi phục màu lông BBN Reddening Shampoo được thiết kế dành riêng cho các giống chó có lông màu nâu – đỏ. Đặc biệt là chó Poodle. Giúp làm sáng màu lông, tăng sắc tố và tạo độ ẩm phù hợp cho lông của chúng. Sữa tắm cho chó khôi phục màu lông BBN Reddening Shampoo nhập khẩu từ Brazil với chiết xuất quả dâu tây có nguồn gốc từ Anh. Chính vì vậy mà nó có hàm lượng chất Pectin cao hơn so với mức bình thường. Giúp nhanh chóng bổ sung thêm dinh dưỡng cho tế bào lông. Phục hồi hiệu quả sự đàn hồi của lông. Đặc biệt là cho các giống chó lông xù, lông dài, lông xoăn.'
,N'Anh', 120, 5, 160000, 4)
--id = 20
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Sữa tắm cho chó có làn da nhạy cảm JOYCE & DOLLS 102 Hypoallergenic Formula', 'sua-tam-cho-cho-co-lan-da-nhay-cam-joyce-dolls-102-hypoallergenic-formula-768x768.jpg', 
N'Sữa tắm cho chó có làn da nhạy cảm JOYCE DOLLS 102 Hypoallergenic Formula phù hợp với tất cả các giống chó. Bao gồm Poodle, Phốc sóc, Alaska, Samoyed, Pug, Becgie… Sữa tắm cho chó có làn da nhạy cảm JOYCE & DOLLS 102 Hypoallergenic Formula chứa thành phần từ chiết xuất tảo lục chlorella và yến mạch. Làm dịu da cho những chú chó có làn da nhạy cảm. Đồng thời giúp cân bằng độ PH của da và duy trì sự bóng mượt của lông. Phù hợp với tất cả các giống chó lông ngắn và dài như Poodle, Pug, Alaska, Becgie… Đảm bảo mang tới cho những người bạn 4 chân cảm giác thoải mái. Khử mùi hôi hiệu quả, an toàn. Lưu giữ hương thơm lâu hơn. Đảm bảo giữ màu lông cho cún cưng bền hơn, chăm sóc làn da khỏe mạnh.'
,N'Hàn Quốc', 100, 8, 240000, 4)
--id = 21
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Mèo Anh lông ngắn', 'meo-anh-long-ngan-british-shorthair.jpg', 
N'British Shorthair là giống mèo cảnh cổ của Vương quốc Anh. Chúng đã có quá trình sinh sống và phát triển trên quần đảo Anh quốc từ hàng ngàn năm.
Từng có nguy cơ bị tuyệt chủng sau hai cuộc chiến tranh thế giới thứ I và II. Nhưng nhờ những nỗ lực phục hồi, ngày nay giống mèo này trở thành một trong các dòng thú kiểng được ưa thích và phổ biến nhất.
Tới nay, giống mèo Brittish Shorthair được hầu hết các tổ chức uy tín như TICA, CFA, WCF công nhận.'
,N'Anh', 10, 10, 1000000, 2)
----id=22
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Mèo Anh lông dài', 'Giong-meo-mat-hai-mau-dac-biet-quy-hiem-1.jpg', 
N'British Shorthair là giống mèo cảnh cổ của Vương quốc Anh. Chúng đã có quá trình sinh sống và phát triển trên quần đảo Anh quốc từ hàng ngàn năm.
Từng có nguy cơ bị tuyệt chủng sau hai cuộc chiến tranh thế giới thứ I và II. Nhưng nhờ những nỗ lực phục hồi, ngày nay giống mèo này trở thành một trong các dòng thú kiểng được ưa thích và phổ biến nhất.
Tới nay, giống mèo Brittish Shorthair được hầu hết các tổ chức uy tín như TICA, CFA, WCF công nhận.'
,N'Anh', 5, 10, 1200000, 2)
--id = 22
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Munchkin lông ngắn', 'meo-munchkin-bicolor-4-thang-9.jpg', 
N'Mèo Munchkin là giống mèo chân ngắn được Hiệp hội mèo thế giới (TICA) công nhận từ năm 1995. Ngày nay, Munchkin chân ngắn đang là một trong những giống mèo được yêu thích nhất trên thế giới. Đặc biệt là các bé mèo chân ngắn, lùn mà lại có thêm đôi tai cụp lại càng được ưa chuộng hơn.'
,N'Hoa kỳ(Mỹ)', 10, 13, 2400000, 2)
--id = 23
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Mèo Scottish Fold tai cụp con', 'meo-ald-trang-tai-cup-cai-8-400x400.png', 
N'Scottish Fold là giống mèo tai cụp được tạo ra trên cơ sở một đột biến gen tự nhiên ở mèo nhà thông thường. Chú mèo tai cụp đầu tiên có tên là Susie, được phát hiện trong trang trại của William Ross ở vùng Perthshire (Scotland) vào năm 1961.
Với đôi tai cụp đáng yêu, Scottish được ghi nhận là giống mèo nhà phổ biến nhất tại Mỹ, Canada, châu Âu. Tại Việt Nam, mèo tai cụp Scottish luôn là lựa chọn số 1 '
,N'Scốtlen (scotland)', 3, 5, 5060000, 2)
--id = 24
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Mèo Bengal', 'meo-bengal.jpg', 
N'Mèo Bengal không phải là một "quý cô" thanh lịch, tinh tế, thướt tha dịu dàng như hầu hết giống mèo cảnh khác. Chúng là những "vận động viên" nhanh nhẹn, mạnh mẽ cùng sự uyển chuyển, cơ bắp như một chú báo rừng.
Mặc dù có vẻ ngoài hoang dã, những Bengal thật sự rất tình cảm với gia đình & vật nuôi khác trong nhà. Tại Dogily Cattery, chúng tôi bị thu hút bởi vẻ ngoài hoang dã và nét đẹp nguyên sơ mà không một loài thú cưng nào có được của giống mèo báo Bengal. Trong suốt lịch sử của, mèo Bengal luôn là một trong những giống mèo quý hiếm nhất, đắt giá và sang trọng. Một chú mèo Bengal cũng là điểm nhấn cho địa vị cao quý của chủ nhân.'
,N'Hoa Kỳ', 6, 8, 909000, 2)
--id = 25
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Mèo Toyer', 'meo-toyger-duoc-nhan-giong-tu-bengal-400x400.jpg', 
N'Mèo Toyger được mệnh danh là "hổ con" . Toyger được lai tạo để giống với những con hổ trong tự nhiên nhất, nhưng được thu cho nhỏ phù hợp với cuộc sống đô thị hiện đại và thân thiện như mèo nhà. Mèo Toyger với vằn hổ ấn tượng. Toyger được lai tạo để giống với những con hổ trong tự nhiên nhất, nhưng được thu cho nhỏ phù hợp với cuộc sống đô thị hiện đại và thân thiện như mèo nhà. Giá mèo Toyger cũng thuộc hàng top trong thế giới mèo nhà mà không phải ai cũng có điều kiện sở hữu.'
,N'Hoa Kỳ', 2, 9, 20000000, 2)
--id = 26
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Mèo Ba Tư', 'meo-ba-tu-duc-dogily-3-thang-3-400x400.jpg', 
N'Mèo Ba tư (mèo Persian) là giống mèo có nguồn gốc từ xứ sở “nghìn lẻ một đêm” huyền thoại. Giống mèo này có khuôn mặt tròn trịa, mõm ngắn và bộ lông dài tha thướt tuyệt đẹp. Với nhiều biến thể gồm: mèo Ba tư truyền thống, mèo Exotic (mèo ba tư lông ngắn), mèo Himalayan và mèo Chichilla. Tại Việt Nam, mèo Ba Tư cùng với mèo lông ngắn Anh là hai giống mèo được giới yêu mèo săn lùng nhất.'
,N'Anh', 3, 10,10000000, 2)
--id = 27
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Mèo Munchkin Cream', 'meo-aln-munchkin-cream-6.png', 
N'Mèo Munchkin là giống mèo chân ngắn được Hiệp hội mèo thế giới (TICA) công nhận từ năm 1995. Ngày nay, Munchkin chân ngắn đang là một trong những giống mèo được yêu thích nhất trên thế giới. Đặc biệt là các bé mèo chân ngắn, lùn mà lại có thêm đôi tai cụp lại càng được ưa chuộng hơn.'
,N'Hoa Kỳ', 2, 11, 5500000, 2)
--id = 28
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'Rọ mõm chó hình mỏ vịt PAW Aduck', 'https://www.petmart.vn/wp-content/uploads/2013/07/ro-mom-cho-hinh-mo-vit-paw-aduck-768x768.jpg', 
N''
,N'', , , )
--id = 29
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'', '', 
N''
,N'', , , )
--id = 30
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'', '', 
N''
,N'', , , )
--id = 31
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'', '', 
N''
,N'', , , )
--id = 32
INSERT INTO DBO.Product([NameP], [ImageP], [Describe], [Origin], [Amount], [Discount], [Price], [CateID]) 
VALUES(N'', '', 
N''
,N'', , , )

--------- MÀU SẮC-------------
GO
INSERT INTO DBO.Color([IdP], [Color], [Ratio]) VALUES(1, N'Nâu vàng', 1)
INSERT INTO DBO.Color([IdP], [Color], [Ratio]) VALUES(1, N'Đen', 1)
INSERT INTO DBO.Color([IdP], [Color], [Ratio]) VALUES(1, N'Vàng ánh cam', 1)
---------Kích thước-------------
GO
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(2, N'1kg', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(2, N'10kg', 9)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(3, N'1 gói', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(3, N'7 gói', 6)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(4, N'1 gói', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(4, N'7 gói', 6)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(5, N'1 gói', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(5, N'7 gói', 6)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(6, N'1 gói', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(6, N'7 gói', 6)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(7, N'1 gói', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(7, N'7 gói', 6)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(8, N'1 gói', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(8, N'6 gói', 5)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(9, N'1 gói', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(9, N'6 gói', 5)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(10, N'1kg', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(10, N'10kg', 9)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(10, N'20kg', 18)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(11, N'1 gói', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(11, N'6 gói', 5)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(12, N'2.5kg', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(12, N'15kg', 5)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(13, N'2kg', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(13, N'15kg', 5)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(14, N'2kg', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(14, N'15kg', 5)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(15, N'1 túi', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(15, N'7 túi', 6)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(16, N'1 túi', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(16, N'7 túi', 6)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(17, N'1 túi', 1)
INSERT INTO DBO.Size([IdP], [Size], [Ratio]) VALUES(17, N'6 túi', 5)

---------Tài khoản-------------
GO
INSERT INTO DBO.Account([Username], [Password], [isAdmin]) VALUES(N'Admin', '1234567', 1)
INSERT INTO DBO.Account([Username], [Password], [isAdmin]) VALUES(N'LuanHan', '1234566', 0)
--------địa chỉ-------------
GO
INSERT INTO DBO.[Address]([IdA], [Name], [Phone], [Address]) VALUES(2, N'Luân', '0344444444', N'Nam Từ Liêm - Hà Nội')
--------đặt hàng------
GO
INSERT INTO DBO.[Order]([CreatedDate], [IdA]) VALUES('03/03/2023', 1)
INSERT INTO DBO.[Order]([CreatedDate], [IdA]) VALUES('10/04/2023', 2)


--------chi tiết đơn đặt------------
GO
INSERT INTO DBO.OrderDetails([IdO], [IdP], [Amount], [Price] , [Status]) VALUES(1, 2, 3, 250000, 1)
INSERT INTO DBO.OrderDetails([IdO], [IdP], [Amount], [Price] , [Status]) VALUES(1, 3, 3, 40000, 1)
INSERT INTO DBO.OrderDetails([IdO], [IdP], [Amount], [Price] , [Status]) VALUES(2, 2, 8, 250000, 0)
INSERT INTO DBO.OrderDetails([IdO], [IdP], [Amount], [Price] , [Status]) VALUES(2, 5, 4, 40000, 1)


GO

INSERT INTO ProductRating([idA], [idP], [rating], [comment], [IdO]) values(1, 2, 4, N'Hàng chất lượng.', 1)
INSERT INTO ProductRating([idA], [idP], [rating], [comment], [IdO]) values(1, 3, 5, N'Hàng chất lượng.', 2)
---------------
select Product.* , nameC
from product 
join Category on Product.CateID = Category.CateID
------------ số lượng đã bán--------
SELECT Product.IdP AS 'pID', 
	   Product.NameP AS 'pName',
       Category.NameC AS 'cName',
	   Product.Amount AS 'pAmount',
       Product.Price AS 'pPrice',
       SUM(OrderDetails.Amount) AS 'sumPrice'
FROM Product
INNER JOIN Category ON Product.CateID = Category.CateID
LEFT JOIN OrderDetails ON Product.IdP = OrderDetails.IdP
where Category.NameC like N'%chó%' or  Product.NameP like N'%mèo%'
GROUP BY Product.NameP, Product.IdP, Category.NameC, Product.Price, Product.Amount
--------------
SELECT Product.IdP AS 'pID', 
	   Product.NameP AS 'pName',
       Category.NameC AS 'cName',
	   Product.Amount AS 'pAmount',
       Product.Price AS 'pPrice',
       SUM(OrderDetails.Amount) AS 'sumPrice'
FROM Product
INNER JOIN Category ON Product.CateID = Category.CateID
LEFT JOIN OrderDetails ON Product.IdP = OrderDetails.IdP
INNER JOIN [Order] ON OrderDetails.IdO = [Order].IdO
WHERE [Order].CreatedDate >= DATEADD(month, -3, GETDATE())
GROUP BY Product.NameP, Product.IdP, Category.NameC, Product.Price, Product.Amount
------------pHỔ BIẾN------------
SELECT Product.*, SUM(OrderDetails.Amount) As sumP
FROM Product
LEFT JOIN OrderDetails ON Product.IdP = OrderDetails.IdP
where Product.CateID = 5
GROUP BY Product.NameP, Product.ImageP, Product.IdP, Product.Origin, Product.Describe ,Product.Discount,  Product.Price, Product.Amount, Product.cateId
ORDER BY SUM(OrderDetails.Amount) DESC

----- giá từ thấp đến cao-----------
SELECT *
FROM Product
ORDER BY (Product.Price - (Product.Price * (Product.Discount / 100.0)))

SELECT *
FROM Product
ORDER BY Product.Price DESC
--------------- MỚI NHẤT
SELECT *
FROM Product
ORDER BY Product.IDp DESC
--------------BÁN CHẠY---------- tỉ lệ sản phẩm bán trên sản phẩm đã có
SELECT p.*, (SUM(od.Amount) * 1.0 / p.Amount) as SalesRatio
FROM Product p
LEFT JOIN OrderDetails od ON p.IdP = od.IdP
GROUP BY p.IdP, p.NameP, p.ImageP, p.Describe, p.Origin, p.Amount, p.Discount, p.Price, p.CateID
ORDER BY SalesRatio DESC
---------END
SELECT *
FROM Product
ORDER BY Product.IDp DESC
SELECT *
FROM Product
JOIN OrderDetails ON Product.IdP = OrderDetails.IdP
ORDER BY SUM(OrderDetails.Amount) DESC
SELECT p.IdP, p.NameP
FROM Product p
JOIN OrderDetails od ON p.IdP = od.IdP
ORDER BY SUM(od.Amount) DESC

--------
select * from Product
EXCEPT select * from Product where CateID=1
EXCEPT select * from Product where CateID=2

--------
SELECT SUM(OrderDetails.Amount) AS 'sumPrice'
FROM Product
LEFT JOIN OrderDetails ON Product.IdP = OrderDetails.IdP
where  Product.IdP = 5
 use SHOPPET
select * from Address where IdA = 2

-----------------
USE SHOPPET
go
SELECT p.*, SUM(od.Amount) AS TotalSold --, AVG(pr.rating) AS AverageRating
FROM Product p
LEFT JOIN OrderDetails od ON p.IdP = od.IdP
LEFT JOIN ProductRating pr ON p.IdP = pr.IdP
where CateID > 2
GROUP BY p.NameP, p.ImageP, p.IdP, p.Origin, p.Describe , p.Discount,  p.Price, p.Amount, p.cateId
ORDER BY SUM(od.Amount) DESC

USE SHOPPET
go
SELECT p.IdP, SUM(od.Amount) AS TotalSold, CAST(AVG(rating * 1.0) AS DECIMAL(10, 1)) AS AverageRating, COUNT(pr.rating) AS TotalRating
FROM Product p
LEFT JOIN OrderDetails od ON p.IdP = od.IdP
LEFT JOIN [Order] o ON o.IdO = od.IdO
LEFT JOIN ProductRating pr ON pr.IdP = p.IdP AND pr.IdA = o.IdA --AND pr.idO =od.IdO
GROUP BY p.IdP
ORDER BY TotalSold DESC;


SELECT dbo.Product.IdP, AVG(dbo.ProductRating.rating) AS AverageRating
FROM dbo.Product
LEFT JOIN dbo.ProductRating ON ProductRating.IdP = Product.IdP
GROUP BY dbo.Product.IdP

SELECT idp, AVG(dbo.ProductRating.rating) AS AverageRating, CAST(AVG(rating) AS DECIMAL(10,2)) AS AverageRat
FROM dbo.ProductRating
GROUP BY IdP

SELECT *  FROM dbo.ProductRating

SELECT IdP, CAST(AVG(rating * 1.0) AS DECIMAL(10, 1)) AS AverageRating
FROM ProductRating
WHERE IdP = 11
GROUP BY IdP;


SELECT idp, SUM(Amount)
FROM dbo.OrderDetails
GROUP BY IdP
SELECT 
    p.IdP AS 'Mã sản phẩm',
    p.NameP AS 'Tên sản phẩm',
    o.CreatedDate AS 'Ngày mua',
    o.Status AS 'Trạng thái'
FROM 
    Product p
    JOIN OrderDetails od ON p.IdP = od.IdP
    JOIN [Order] o ON od.IdO = o.IdO

SELECT Product.IdP, [Order].idO, Product.NameP, [Order].CreatedDate, [Order].[Status]
FROM Product
INNER JOIN OrderDetails ON Product.IdP = OrderDetails.IdP
INNER JOIN [Order] ON OrderDetails.IdO = [Order].IdO
WHERE [Order].IdA = 2

SELECT Product.idp, Product.NameP, Product.Origin, OrderDetails.IdO, OrderDetails.Amount, OrderDetails.Price
FROM Product
INNER JOIN OrderDetails ON Product.IdP = OrderDetails.IdP
WHERE OrderDetails.IdO = 2 and OrderDetails.IdP = 2

select PR.*, A.imageA, A.Username
from ProductRating AS PR
LEFT JOIN Account AS A ON A.IdA = PR.IdA
WHERE PR.IdP = 2


WITH Ratings AS (
SELECT rating FROM (VALUES (5), (4), (3), (2), (1)) AS R(rating)
)
SELECT Ratings.rating, COUNT(ProductRating.rating) AS Count
FROM Ratings
LEFT JOIN ProductRating ON Ratings.rating = ProductRating.rating AND ProductRating.IdP = 3
GROUP BY Ratings.rating;


SELECT p.IdP ,
	p.NameP ,
	p.ImageP ,
	p.Describe ,
	p.Origin , 
	p.Amount,
	p.Discount,
	p.Price,
	p.CateID,
	SUM(od.Amount) AS TotalSold, 
	AVG(pr.rating) AS AverageRating, 
	COUNT(pr.rating) AS TotalRating
FROM Product as p
LEFT JOIN OrderDetails od ON p.IdP = od.IdP
LEFT JOIN ProductRating pr ON p.IdP = pr.IdP and p.idp = 3
GROUP BY p.NameP, p.ImageP, p.IdP, p.Origin, p.Describe , p.Discount, p.Price, p.Amount, p.cateId, pr.rating

SELECT P.Amount - COALESCE(SUM(OD.Amount), 0) AS Remaining
FROM Product AS P
LEFT JOIN OrderDetails AS OD ON P.IdP = OD.IdP
WHERE P.IdP = 6
GROUP BY P.Amount;

SELECT 
    od.IdP, 
    P.NameP, 
    SUM(OD.Amount) AS SoldQuantity, 
    AVG(PR.rating) AS Rating, 
    COUNT(PR.IdA) AS NumOfRatings
FROM 
    Product P
    LEFT JOIN OrderDetails OD ON P.IdP = OD.IdP
    LEFT JOIN ProductRating PR ON P.IdP = PR.IdP
GROUP BY 
    P.NameP, OD.IdP, pr.IdP, p.IdP




	SELECT Product.IdP, Product.Amount - COALESCE(SUM(OrderDetails.Amount), 0)
FROM dbo.Product 
LEFT JOIN dbo.OrderDetails ON OrderDetails.IdP = Product.IdP AND Status = 2
GROUP BY Product.IdP,  Product.Amount

DECLARE @n INT = 4 -- Thay đổi giá trị n thành số ngày mong muốn

SELECT	COALESCE(SUM(od.Amount * od.Price), 0) AS TotalRevenue
FROM dbo.[Order] o
JOIN dbo.OrderDetails od ON od.IdO = o.IdO
WHERE o.CreatedDate >= DATEADD(DAY, -@n, GETDATE()) -- Lấy các đơn hàng trong khoảng n ngày gần nhất
INSERT dbo.Payment
VALUES
(   28,      -- IdO - int
    null,   -- bankcode - nvarchar(255)
    13500,    -- priceBank - nvarchar(255)
    13500,      -- priceSum - int
    null,   -- OrderInfo - nvarchar(255)
    '2023-05-20' -- payDate - date
    )
SELECT SUM(Price) FROM dbo.OrderDetails WHERE IdO = 28