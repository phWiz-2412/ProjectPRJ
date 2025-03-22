
# E-Commerce Website

## Giới thiệu
Dự án này là một website bán hàng trực tuyến, hỗ trợ hai loại tài khoản: **Admin** và **User**. Người dùng có thể duyệt sản phẩm, thêm vào giỏ hàng và thanh toán, trong khi Admin có thể quản lý sản phẩm, đơn hàng và tài khoản người dùng.

## Công nghệ sử dụng
- **Backend:** Java Servlet, JSP
- **Frontend:** HTML, CSS, JavaScript, Bootstrap
- **Cơ sở dữ liệu:** MySQL
- **Thư viện & Công cụ hỗ trợ:** JSTL, EL, JDBC, Tomcat Server, NetBeans

## Chức năng chính
### 1. Người dùng (User)
- Đăng ký, đăng nhập
- Xem danh sách sản phẩm
- Thêm sản phẩm vào giỏ hàng
- Thanh toán đơn hàng
- Xem lịch sử mua hàng

### 2. Quản trị viên (Admin)
- Quản lý sản phẩm (Thêm, sửa, xóa)
- Quản lý đơn hàng
- Quản lý người dùng

## Cấu trúc thư mục
```
E-Commerce-Website/
|-- src/
|   |-- controller/       # Các servlet điều hướng
        |--AddControll.java
        |--AdminOrderController.
        |--
        |--
|   |-- model/            # Các lớp xử lý dữ liệu
|   |-- dao/              # Truy vấn database
|-- web/
|   |-- css/              # File CSS
|   |-- js/               # File JavaScript
|   |-- views/            # Các trang JSP
|-- WEB-INF/
|   |-- web.xml           # Cấu hình ứng dụng
|-- sql/                  # File khởi tạo database
|-- README.md             # Tài liệu này
```

## Cách cài đặt và chạy dự án
1. Clone repository:
   ```sh
   git clone https://github.com/your-username/ecommerce-website.git
   ```
2. Import vào NetBeans
3. Cấu hình MySQL:
   - Tạo database
   - Import file SQL
4. Chạy dự án trên Tomcat

## Tài khoản mẫu
- **Admin**: `admin@example.com` / `admin123`
- **User**: `user@example.com` / `user123`

## Đóng góp
Nếu bạn muốn đóng góp, hãy tạo một nhánh mới và gửi Pull Request. Mọi ý kiến đóng góp đều được hoan nghênh!

## Giấy phép
Dự án này được phát hành theo [MIT License](LICENSE).

