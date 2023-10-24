create database iot
go
use iot
go

create table account(
	code varchar(15) PRIMARY KEY,
	[name] nvarchar(255) NOT NULL,
	email varchar(50) NOT NULL,
	[password] varchar(15) NOT NULL,
)
---- Sinh viên
go
create table student (
	rfid varchar(15) PRIMARY KEY,
	studentcode varchar(15) UNIQUE NOT NULL,
	FOREIGN KEY (studentCode) REFERENCES account(code)
)

---- MÔN HỌC KỲ HỌC
go
create table subjectSemester(
	subjectSemesterId BIGINT IDENTITY(1,1) PRIMARY KEY,
	[subject] nvarchar(255) NOT NULL, --môn học
	[semester] nvarchar(255) NOT NULL, --kỳ học
	schoolYear VARCHAR(9) NOT NULL,
	CONSTRAINT UC_SubjectSemester UNIQUE ([subject], [semester], schoolYear)
)

-- Sinh viên lớp học 
go 
create table studentClass (
	studentClassId BIGINT IDENTITY(1,1) PRIMARY KEY,
	code varchar(15) NOT NULL,
	subjectSemesterId BIGINT NOT NULL,
	FOREIGN KEY (code) REFERENCES account(code),
	FOREIGN KEY (subjectSemesterId) REFERENCES subjectSemester(subjectSemesterId),
)
-- Kíp học
go
create table studycrew (
	studycrewId varchar(5) PRIMARY KEY,
    starttime TIME NOT NULL,
    endtime TIME NOT NULL,
)
-- Lịch học
CREATE TABLE schedule (
    scheduleId BIGINT IDENTITY(1,1) PRIMARY KEY,
    subjectSemesterId BIGINT NOT NULL,
    studycrewId VARCHAR(5) NOT NULL,
    scheduleDate Date NOT NULL,
    FOREIGN KEY (subjectSemesterId) REFERENCES subjectSemester(subjectSemesterId),
    FOREIGN KEY (studycrewId) REFERENCES studycrew(studycrewId)
);
-------
CREATE TABLE attendance (
    attendanceId BIGINT IDENTITY(1,1) PRIMARY KEY,
    scheduleId BIGINT NOT NULL,
    attendanceDate Date DEFAULT SYSDATETIME() NOT NULL,
    --attendanceTime TIMESTAMP DEFAULT SYSDATETIME() NOT NULL, -- Trường giờ điểm danh
    attendanceStatus INT, -- Trạng thái điểm danh
    FOREIGN KEY (scheduleId) REFERENCES schedule(scheduleId)
);
go
INSERT INTO DBO.ACCOUNT(code, [name], [password], email) VALUES('B20DCCN410', N'Hán Văn Luân', 'B20DCCN410', 'LuanHV.B20CN410@stu.ptit.edu.vn')
INSERT INTO DBO.ACCOUNT(code, [name], [password], email) VALUES('B20DCCN268', N'Đỗ Đăng Dương', 'B20DCCN268', 'DuongDD.B20CN268@stu.ptit.edu.vn')
INSERT INTO DBO.ACCOUNT(code, [name], [password], email) VALUES('B20DCCN004', N'Nguyễn Quốc Anh', 'B20DCCN004', 'AnhNQ.B20CN004@stu.ptit.edu.vn')
INSERT INTO DBO.ACCOUNT(code, [name], [password], email) VALUES('B20DCCN362', N'Phan Trọng Kiều', 'B20DCCN362', 'KieuPT.B20CN362@stu.ptit.edu.vn')
INSERT INTO DBO.ACCOUNT(code, [name], [password], email) VALUES('B20DCCN290', N'Cao Duy Hải', 'B20DCCN290', 'HaiCD.B20CN290@stu.ptit.edu.vn')
INSERT INTO DBO.ACCOUNT(code, [name], [password], email) VALUES('B20DCCN640', N'Trần Đình Tính', 'B20DCCN640', 'TinhTD.B20CN640@stu.ptit.edu.vn')
INSERT INTO DBO.ACCOUNT(code, [name], [password], email) VALUES('GV01KCB001', N'Dương Trần Đức', '12345678', 'dungtran@gmail.com')
INSERT INTO DBO.ACCOUNT(code, [name], [password], email) VALUES('GV10KCQ020', N'Đào Ngọc Phong', '12345678', 'phongdn@gmail.com')
go

INSERT INTO student(rfid, studentcode) VALUES('h123hag', 'B20DCCN410')

INSERT INTO subjectSemester([subject], [semester], [schoolYear]) VALUES(N'IoT và ứng dụng', N'Học kỳ I', '2023-2024')
INSERT INTO subjectSemester([subject], [semester], [schoolYear]) VALUES(N'Quản lý dự án phần mềm', N'Học kỳ I', '2023-2024')
INSERT INTO subjectSemester([subject], [semester], [schoolYear]) VALUES(N'Phân tích và thiết kế hệ thống thông tin', N'Học kỳ I', '2023-2024')
INSERT INTO subjectSemester([subject], [semester], [schoolYear]) VALUES(N'Lập trình web', N'Học kỳ I', N'2023-2024')

go
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('B20DCCN410', 1)
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('B20DCCN268', 1)
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('B20DCCN004', 1)
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('B20DCCN362', 1)
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('B20DCCN290', 1)
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('B20DCCN640', 1)

INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('B20DCCN410', 2)
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('B20DCCN410', 3)

INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('GV01KCB001', 1)
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('GV01KCB001', 4)
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('GV10KCQ020', 3)
INSERT INTO studentClass([code], [subjectSemesterId]) VALUES('GV10KCQ020', 2)

INSERT INTO studycrew (studycrewId, starttime, endtime)
VALUES 
    ('KIP01', '07:00:00', '8:50:00'),
    ('KIP02', '9:00:00', '9:50:00'),
	('KIP03', '10:00:00', '11:50:00'),
	('KIP04', '13:00:00', '14:50:00'),
	('KIP05', '15:00:00', '16:50:00'),
	('KIP06', '17:00:00', '18:50:00'),
	('KIP07', '18:00:00', '19:50:00');

INSERT INTO schedule (subjectSemesterId, studycrewId, scheduleDate)
VALUES 
    (1, 'KIP01', GETDATE()),
    (2, 'KIP02', '2023/10/21'),
    (3, 'KIP03', '2023/10/20');


