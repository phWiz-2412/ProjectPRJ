CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY, 
    UserName NVARCHAR(50) UNIQUE NOT NULL, 
    Password NVARCHAR(255) NOT NULL, 
    Role NVARCHAR(10) NOT NULL DEFAULT 'Customer', 

    CONSTRAINT CK_Users_Role CHECK (Role IN ('Admin', 'Customer'))
);
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY, 
    FullName NVARCHAR(100) NOT NULL, 
    Email NVARCHAR(100) UNIQUE NOT NULL, 
    PhoneNumber NVARCHAR(15) UNIQUE NOT NULL, 
    Address NVARCHAR(255), 
    RegistrationDate DATETIME DEFAULT GETDATE(),
    UserID INT ,  

    CONSTRAINT FK_Customers_Users FOREIGN KEY (UserID) 
    REFERENCES Users(UserID) ON DELETE CASCADE
);
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,  -- ID tự động tăng
    ProductName NVARCHAR(100) NOT NULL,  -- Tên sản phẩm
    Brand NVARCHAR(50) NOT NULL,  -- Thương hiệu
   
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),  -- Giá sản phẩm (Không âm)
    
    Description NVARCHAR(500),  -- Mô tả sản phẩm
    ImageURL NVARCHAR(255),  -- Đường dẫn ảnh sản phẩm
    DateAdded DATE DEFAULT GETDATE()  -- Ngày thêm sản phẩm (mặc định là ngày hiện tại)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY, 
    CustomerID INT NOT NULL, 
    OrderDate DATETIME DEFAULT GETDATE(), 
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0), 
    Status NVARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),

    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) 
    REFERENCES Customers(CustomerID) ON DELETE CASCADE
);
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




INSERT INTO Users (Username, Password, Role) VALUES
('admin', '1', 'Admin'),
('user1', '1', 'Customer'),
('user2', '1', 'Customer');

INSERT INTO Customers (FullName, Email, PhoneNumber, Address, UserID) VALUES
(N'Nguyễn Văn A', 'nguyenvana@example.com', '0987654321', N'Hà Nội', 2),
(N'Trần Thị B', 'tranthib@example.com', '0978123456', 'TP.HCM', 3);
INSERT INTO Products (ProductName, Brand,  Price, [Description], ImageURL) VALUES
('Nike Air Max 90', 'Nike', 120.00,  N'Giày thể thao nam cao cấp', 'https://static.nike.com/a/images/t_default/yo8q4g51so6rylfl6w14/AIR+MAX+90.png'),
('Adidas Ultraboost 22', 'Adidas',  160.00, N'Giày chạy bộ hiệu suất cao', 'https://product.hstatic.net/1000391653/product/gx5459_1115db15ed644ed592e6e6ad637d2ac9_master.jpg'),
('Puma RS-X3', 'Puma',  115.00,  N'Phong cách hiện đại và năng động', 'https://ktsneaker.com/upload/product/117-4201.jpg'),
('New Balance 990v5', 'New Balance',  180.00,  N'Dòng giày cổ điển, thoải mái', 'https://authentic-shoes.com/wp-content/uploads/2023/04/1613109025729_newbalance2_473f9b5a36d44d3a8880d5c227ca1b90.jpeg'),
('Asics Gel-Kayano 28', 'Asics',  140.00,  N'Giày chạy bộ hỗ trợ cao', 'https://www.jordan1.vn/wp-content/uploads/2023/09/1011b189_002_sb_fr_glb_d9b352565_6d2d34a05f564e31aedf5a3335fd67b9.png'),
('Reebok Nano X2', 'Reebok',  130.00,  N'Giày tập gym đa dụng', 'https://www.runningshoesguru.com/wp-content/uploads/2022/05/Reebok-Nano-X2-pic-03.jpeg'),
('Under Armour HOVR Phantom', 'Under Armour', 150.00,  N'Giày thể thao công nghệ HOVR', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqR66MQR3KzJajDeFNOxv_y1_VTsHQDxjm-A&s'),
('Vans Old Skool', 'Vans',  80.00,  N'Giày sneaker thời trang cổ điển', 'https://bizweb.dktcdn.net/100/140/774/files/vans-forgotten-bones-old-skool-vn0a4bv5v8v-2.jpg?v=1569426630840'),
('Converse Chuck Taylor', 'Converse',  75.00,  N'Giày vải kinh điển', 'https://bizweb.dktcdn.net/thumb/grande/100/347/923/products/568498c-2.jpg?v=1597673314487'),
('Balenciaga Triple S', 'Balenciaga',  950.00,  N'Giày sneaker cao cấp thời trang', 'https://mcgrocer.com/cdn/shop/products/balenciaga-triple-s-sneakers_17082442_34191510_2048.jpg?v=1688709980');
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 120.00),  -- Đơn hàng 1: 2 đôi Nike Air Max
(1, 3, 1, 110.00),  -- Đơn hàng 1: 1 đôi Puma RS-X
(2, 2, 1, 150.00);  -- Đơn hàng 2: 1 đôi Adidas Ultraboost
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status) VALUES
(1, GETDATE(), 270.00, 'Pending'),
(2, GETDATE(), 150.00, 'Shipped');

DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Users;
-- Tạo bảng Categories
CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,  -- ID tự động tăng
    CategoryName NVARCHAR(100) NOT NULL UNIQUE, -- Tên danh mục (duy nhất)
    
);

-- Thêm cột CategoryID vào bảng Products
ALTER TABLE Products 
ADD CategoryID INT;

-- Tạo khóa ngoại liên kết Products với Categories
ALTER TABLE Products 
ADD CONSTRAINT FK_Products_Category
FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) 
ON DELETE SET NULL; -- Nếu xóa Category, các sản phẩm vẫn tồn tại
INSERT INTO Category (CategoryName) VALUES
(N'Giày thể thao'),
(N'Giày thời trang');
UPDATE Products SET CategoryID = 1 WHERE ProductName LIKE '%Nike Air Max 90%';
UPDATE Products SET CategoryID = 1 WHERE ProductName LIKE '%Adidas Ultraboost 22%';
UPDATE Products SET CategoryID = 1 WHERE ProductName LIKE '%Puma RS-X3%';
UPDATE Products SET CategoryID = 2 WHERE ProductName LIKE '%New Balance 990v5%';
UPDATE Products SET CategoryID = 1 WHERE ProductName LIKE '%Asics Gel-Kayano 28%';
UPDATE Products SET CategoryID = 1 WHERE ProductName LIKE '%Reebok Nano X2%';
UPDATE Products SET CategoryID = 2 WHERE ProductName LIKE '%Under Armour HOVR Phantom%';
UPDATE Products SET CategoryID = 2 WHERE ProductName LIKE '%Vans Old Skool%';
UPDATE Products SET CategoryID = 2 WHERE ProductName LIKE '%Converse Chuck Taylor%';
UPDATE Products SET CategoryID = 2 WHERE ProductName LIKE '%Balenciaga Triple S%';
select *from Users
where UserName = ?
and [Password] =?

WHERE ProductName = 'Balenciaga Triple S';
insert [dbo].[Products]([ProductName], [ImageURL], [Price], [Brand], [Description], [CategoryID]) 
values('peakdep','https://peaksports.my/wp-content/uploads/2024/08/sg-11134201-22110-m65hchtw4wjv95.jpg','190','PEAK','xin','1')
delete from Products
where ProductID =?
select *from Products
update Products
set [ProductName] = ?,
ImageURL = ?,
Price =?,
Brand = ?,
[Description] =?,
CategoryID = ?
where ProductID =?

Im