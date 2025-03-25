CREATE DATABASE Assignment;
USE Assignment;


-- Tạo bảng Users
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY, 
    UserName NVARCHAR(50) UNIQUE NOT NULL, 
    Password NVARCHAR(255) NOT NULL, 
    Role NVARCHAR(10) NOT NULL DEFAULT 'Customer', 
    CONSTRAINT CK_Users_Role CHECK (Role IN ('Admin', 'Customer'))
);

-- Tạo bảng Customers
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY, 
    FullName NVARCHAR(100) NOT NULL, 
    Email NVARCHAR(100) UNIQUE NOT NULL, 
    PhoneNumber NVARCHAR(15) UNIQUE NOT NULL, 
    Address NVARCHAR(255), 
    RegistrationDate DATETIME DEFAULT GETDATE(),
    UserID INT,  
    CONSTRAINT FK_Customers_Users FOREIGN KEY (UserID) 
        REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Tạo bảng Category
CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY, 
    CategoryName NVARCHAR(100) NOT NULL UNIQUE
);

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,  
    ProductName NVARCHAR(100) NOT NULL,  
    Brand NVARCHAR(50) NOT NULL,   
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),  
    Description NVARCHAR(500),  
    ImageURL NVARCHAR(255),  
    DateAdded DATE DEFAULT GETDATE(),
    CategoryID INT,
	Stock INT,
    CONSTRAINT FK_Products_Category FOREIGN KEY (CategoryID) 
        REFERENCES Category(CategoryID) ON DELETE SET NULL
);

-- Tạo bảng Cart
CREATE TABLE Cart (
    CartID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    DateAdded DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Cart_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    CONSTRAINT FK_Cart_Products FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY, 
    CustomerID INT NOT NULL, 
    OrderDate DATETIME DEFAULT GETDATE(), 
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0), 
    Status NVARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) 
        REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- Tạo bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY, 
    OrderID INT NOT NULL, 
    ProductID INT NOT NULL, 
    Quantity INT NOT NULL CHECK (Quantity > 0),  
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),  
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) 
        REFERENCES Orders(OrderID) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) 
        REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Tạo bảng Comments
CREATE TABLE Comments (
    CommentID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    CommentText NVARCHAR(500) NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5), -- Điểm đánh giá từ 1 đến 5
    CommentDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Comments_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    CONSTRAINT FK_Comments_Products FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Chèn dữ liệu vào bảng Users
INSERT INTO Users (UserName, Password, Role) VALUES
('admin', '1', 'Admin'),
('user1', '1', 'Customer'),
('user2', '1', 'Customer');

-- Chèn dữ liệu vào bảng Customers
INSERT INTO Customers (FullName, Email, PhoneNumber, Address, UserID) VALUES
(N'Nguyễn Văn A', 'nguyenvana@example.com', '0987654321', N'Hà Nội', 2),
(N'Trần Thị B', 'tranthib@example.com', '0978123456', N'TP.HCM', 3);

-- Chèn dữ liệu mới vào bảng Comments
DELETE FROM Comments;
INSERT INTO Comments (CustomerID, ProductID, CommentText, Rating, CommentDate) VALUES
(1, 27, N'Giày rất thoải mái, đáng giá tiền!', 5, GETDATE()), 
(1, 28, N'Đẹp nhưng hơi chật ở phần mũi giày.', 3, GETDATE()), 
(2, 29, N'Chất lượng tuyệt vời, chạy bộ rất êm.', 4, GETDATE()), 
(2, 30, N'Thích thiết kế cổ điển, nhưng giá hơi cao.', 4, GETDATE());

-- Chèn dữ liệu vào bảng Category
INSERT INTO Category (CategoryName) VALUES
(N'Giày Lining chính hãng'),
(N'Giày trẻ em'),
(N'Giày thể thao'),
(N'Giày thời trang');

-- Chèn dữ liệu mới vào bảng Products
DELETE FROM Products;
INSERT INTO Products (ProductName, Brand, Price, [Description], ImageURL, CategoryID, Stock) VALUES
('Air Force 1', 'Nike', 130.00, N'Giày thể thao cổ điển', 'https://github.com/phWiz-2412/ProjectPRJ/blob/main/pic/Air%20Force%201%2007.jpg?raw=true', 3, 10),
('Air Yeezy Samples', 'Nike', 1800000.00, N'Phiên bản mẫu hiếm của Yeezy', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Air%20Yeezy%20Samples.jpg', 3, 5),
('Chuck 70 Plus', 'Converse', 95.00, N'Giày Converse Chuck 70 phiên bản Plus', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Chuck%2070%20Plus.jpg', 4, 15),
('Chuck 70', 'Converse', 87.50, N'Giày Converse Chuck 70 cổ điển', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Chuck%2070.jpg', 4, 20),
('Curve Runner New York Yankees', 'MLB', 125.00, N'Giày MLB với thiết kế thời trang', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Curve%20Runner%20New%20York%20Yankees.jpg', 4, 10),
('Dunk Low Retro', 'Nike', 160.00, N'Giày Nike Dunk Low phong cách retro', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Dunk%20Low%20Retro.jpg', 3, 15),
('Fresh Foam X 1080v14', 'New Balance', 165.00, N'Giày chạy bộ êm ái', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Fresh%20Foam%20X%201080v14.jpg', 3, 12),
('Giay Ultraboost 5 trang ID8818 HM1', 'Adidas', 190.00, N'Giày Adidas Ultraboost 5', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Giay_Ultraboost_5_trang_ID8818_HM1.jpg', 3, 10),
('Mercurial Superfly 10 Elite', 'Nike', 287.50, N'Giày bóng đá Nike Mercurial', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Mercurial%20Superfly%2010%20Elite.jpg', 2, 8),
('OLD SKOOL MULTI BLOCK BLUE', 'Vans', 65.00, N'Giày Vans Old Skool nhiều màu', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/OLD%20SKOOL%20MULTI%20BLOCK%20BLUE.jpg', 4, 20),
('P-6000', 'Nike', 110.00, N'Giày chạy bộ Nike P-6000', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/P-6000.jpg', 3, 18),
('The Dynasty Collection', 'Jordan', 8000000.00, N'Bộ sưu tập giày Jordan hiếm', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/The%20Dynasty%20Collection.jpg', 3, 5),
('The Last Dance Air Jordan 13', 'Jordan', 2200000.00, N'Giày Jordan 13 The Last Dance', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/The%20Last%20Dance%20Air%20Jordan%2013.jpg', 3, 7),
('Triple S Sneaker in Black', 'Balenciaga', 1000.00, N'Giày Balenciaga Triple S màu đen', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Triple%20S%20Sneaker%20in%20Black.jpg', 4, 4),
('Wave Rider 27 Ssw', 'Mizuno', 135.00, N'Giày chạy bộ Mizuno Wave Rider 27', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Wave%20Rider%2027%20Ssw.jpg', 3, 10),
('Wave Rider 28', 'Mizuno', 140.00, N'Giày chạy bộ Mizuno Wave Rider 28', 'https://github.com/phWiz-2412/ProjectPRJ/raw/main/pic/Wave%20Rider%2028.jpg', 3, 10);

-- Chèn dữ liệu vào bảng Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status) VALUES
(1, GETDATE(), 405.00, 'Pending'),  -- Tổng tiền: 1 Air Force 1 (130) + 1 Dunk Low Retro (160) + 1 P-6000 (110)
(2, GETDATE(), 287.50, 'Shipped');  -- Tổng tiền: 1 Mercurial Superfly 10 Elite (287.50)

-- Chèn dữ liệu vào bảng OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 130.00),  -- Đơn hàng 1: 1 đôi Air Force 1
(1, 6, 1, 160.00),  -- Đơn hàng 1: 1 đôi Dunk Low Retro
(1, 11, 1, 110.00), -- Đơn hàng 1: 1 đôi P-6000
(2, 9, 1, 287.50);  -- Đơn hàng 2: 1 đôi Mercurial Superfly 10 Elite
