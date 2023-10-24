create database HLIVES
GO
use HLIVES
GO
CREATE TABLE [User] (
    userid BIGINT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
	[name] NVARCHAR(255),
    email VARCHAR(255),
    [password] VARCHAR(255) NOT NULL,
	[bio] nvarchar(max),
	avatar varchar(255),
    [tick] int,
    [createdat] DATE DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
    [updatedat] DATE DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL
);
GO
CREATE TABLE Follow (
	followid varchar(255) primary key,
	followerid BIGINT not null ,
	followingid BIGINT not null,
	createdat DATE DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	FOREIGN KEY (followerid) REFERENCES [USER](USERID),
	FOREIGN KEY (followingid) REFERENCES [USER](USERID)
)
GO
CREATE TABLE MessageUser (
	messageId INT primary key,
	senderId int FOREIGN KEY (senderId) REFERENCES [USER](USERID),
	receiverId int FOREIGN KEY (senderId) REFERENCES [USER](USERID),
	content NVARCHAR(MAX),
	createdAt DATE DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL
)
GO
CREATE TABLE Video (
	videoid BIGINT IDENTITY(1,1) PRIMARY KEY, --Mã duy nhất định danh cho mỗi video.
	userid BIGINT NOT NULL, --Mã định danh của người dùng tạo video. (Liên kết với thực thể "Người dùng")
	title NVARCHAR(MAX), --Tiêu đề của video.
	[description] NVARCHAR(MAX), --Mô tả ngắn về nội dung của video.
	nameurl VARCHAR(MAX) NOT NULL, --Đường dẫn đến video trên máy chủ hoặc dịch vụ lưu trữ.
	createdat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, --Thời gian tạo video.
	updatedat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, --Thời gian cập nhật video.
	--posted_at DATE, --Thời gian mà video được đăng lên trang chủ hoặc danh sách phát.
	--viewCount INT, --Số lượt xem của video.
	--likeCount INT, --Số lượt thích của video.
	--commentCount INT --Số lượt bình luận của video.
	FOREIGN KEY (USERID) REFERENCES [USER](USERID)
)
GO
CREATE TABLE LikeVideo(
	userid BIGINT NOT NULL,  -- ID của người dùng.
	videoid BIGINT NOT NULL, --ID của video được thích.
	stamptime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, --Thời gian người dùng thích video.
	FOREIGN KEY (USERID) REFERENCES [USER](USERID),
	FOREIGN KEY (videoID) REFERENCES [Video](videoID)
)
GO
CREATE TABLE VideoViews (
	UserID INT NOT NULL,  -- ID của người dùng xem.
	VideoID INT NOT NULL, --ID của video được xem.
	FOREIGN KEY (USERID) REFERENCES [USER](USERID),
	FOREIGN KEY (videoID) REFERENCES [Video](videoID)
)

GO
CREATE TABLE CommentVideo(
	CommentID int PRIMARY KEY,
	userID INT not null, --ID của người dùng bình luận.
	videoID int not null, --ID của video mà bình luận được thêm vào.
	content NVARCHAR(MAX), --Nội dung bình luận.
	stamptime DATE DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL, --Thời gian bình luận.
	FOREIGN KEY (USERID) REFERENCES [USER](USERID),
	FOREIGN KEY (videoID) REFERENCES [Video](videoID)
)
GO
CREATE TABLE ReplieVideo (
	ReplieId int primary key,
	UserID int not null, --ID của người dùng trả lời.
	CommentID int not null, -- ID của bình luận mà phần trả lời được thêm vào.
	Content NVARCHAR(MAX),
	stamptime DATE DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL, --Thời gian TRẢ LỜI bình luận.
	FOREIGN KEY (USERID) REFERENCES [USER](USERID),
	FOREIGN KEY (CommentID) REFERENCES [CommentVideo](CommentID)
)








---
insert into [user]([username], [name], [email], [password], [bio], [avatar], [tick], [createdat], [updatedat] ) 
Values ('hoaahanassii', N'Đào Lê Phương Hoa', 'phuonghoa@gmail.com', '12345678', N'✨ 1998 ✨\nVietnam 🇻🇳\nĐỪNG LẤY VIDEO CỦA TÔI ĐI SO SÁNH NỮA. XIN HÃY TÔN TRỌNG !',
'https://files.fullstack.edu.vn/f8-tiktok/users/2/627394cb56d66.jpg', 0, '2022-05-05', '2022-05-05')

insert into [user]([username], [name], [email], [password], [bio], [avatar], [tick], [createdat], [updatedat] ) 
Values('duykhang1301', N'Duy Khanh', 'duykhanh@gmail.com', '1234578', N'ĐỪNG LẤY VIDEO CỦA TÔI ĐI SO SÁNH NỮA. XIN HÃY TÔN TRỌNG',
'https://files.fullstack.edu.vn/f8-tiktok/users/5203/644a3d01ca0cb.jpg', 1, '2023-03-01', '2023-04-10')

insert into [user]([username], [name], [email], [password], [bio], [avatar], [tick], [createdat], [updatedat] ) 
Values('xuanbachdev', N'Đỗ Xuân Bách', 'xuanbachdev@gmail.com', '12e4567', N'xuanbachdev',
'https://files.fullstack.edu.vn/f8-tiktok/users/211/63c12e11ab47e.jpg', 1, '2022-09-11', '2023-04-11')

insert into [user]([username], [name], [email], [password], [bio], [avatar], [tick], [createdat], [updatedat] ) 
Values('zeronine', N'Hán Văn Luân', 'luanhan@gmail.com', '12he4567', N'Luân Hán dz',
'https://files.fullstack.edu.vn/f8-tiktok/users/211/63c12e11ab47e.jpg', 1, '2022-09-11', '2023-04-11')

insert into [user]([username], [name], [email], [password], [bio], [avatar], [tick], [createdat], [updatedat] ) 
Values('HanLuan09', N'Hán Văn Luân', 'luanhan12@gmail.com', '12he686', N'Luân Hán',
'https://files.fullstack.edu.vn/f8-tiktok/users/211/63c12e11ab47e.jpg', 1, '2022-10-11', '2023-04-11')

insert into [user]([username], [name], [email], [password], [bio], [avatar], [tick], [createdat], [updatedat] ) 
