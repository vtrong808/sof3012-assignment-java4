CREATE DATABASE PolyOE_ASM;
GO

USE PolyOE_ASM;
GO

-- 1. Bảng Users (Người dùng & Quản trị viên)
CREATE TABLE Users (
    Id NVARCHAR(20) PRIMARY KEY,     -- Username
    Password NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Fullname NVARCHAR(100) NOT NULL,
    Admin BIT DEFAULT 0              -- 0: User, 1: Admin
);

-- 2. Bảng Video (Phim/Clip)
CREATE TABLE Video (
    Id NVARCHAR(20) PRIMARY KEY,     -- Video Code (e.g., V001)
    Title NVARCHAR(255) NOT NULL,    -- Sửa lỗi chính tả 'Titile' trong ảnh
    Poster NVARCHAR(255),            -- Link ảnh hoặc tên file ảnh
    Views INT DEFAULT 0,
    Description NVARCHAR(MAX),
    Active BIT DEFAULT 1             -- 1: Đang chiếu, 0: Ẩn
);

-- 3. Bảng Favorite (Lưu video yêu thích)
CREATE TABLE Favorite (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId NVARCHAR(20) NOT NULL,
    VideoId NVARCHAR(20) NOT NULL,
    LikeDate DATE DEFAULT GETDATE(),

    CONSTRAINT FK_Fav_User FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Fav_Video FOREIGN KEY (VideoId) REFERENCES Video(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_Fav_User_Video UNIQUE (UserId, VideoId) -- Mỗi người chỉ like 1 video 1 lần
);

-- 4. Bảng Share (Chia sẻ video qua email)
CREATE TABLE Share (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId NVARCHAR(20) NOT NULL,
    VideoId NVARCHAR(20) NOT NULL,
    Emails NVARCHAR(MAX) NOT NULL,   -- Danh sách email nhận
    ShareDate DATE DEFAULT GETDATE(),

    CONSTRAINT FK_Share_User FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Share_Video FOREIGN KEY (VideoId) REFERENCES Video(Id) ON DELETE CASCADE
);
GO

-- Thêm dữ liệu mẫu để test giao diện
INSERT INTO Users (Id, Password, Email, Fullname, Admin) VALUES 
('admin', '123', 'admin@poly.edu.vn', N'Admin Manager', 1),
('teonv', '123', 'teonv@gmail.com', N'Nguyễn Văn Tèo', 0);

INSERT INTO Video (Id, Title, Poster, Views, Description, Active) VALUES 
('V01', N'Java Programming 101', 'v1.jpg', 1500, N'Hướng dẫn Java cơ bản', 1),
('V02', N'Spring Boot Tutorial', 'v2.jpg', 2300, N'Học Spring Boot trong 10 phút', 1),
('V03', N'Hibernate Deep Dive', 'v3.jpg', 500, N'Tìm hiểu sâu về JPA/Hibernate', 1),
('V04', N'Angular vs React', 'v4.jpg', 9999, N'So sánh Frontend Framework', 0); -- Video này bị ẩn