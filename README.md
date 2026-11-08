# Topic 06 – Week 13
Biểu mẫu & kiểm tra dữ liệu

## Kiến trúc
```
lib/
├── app/app.dart
├── core/validators/input_validators.dart
├── features/registration/
│   ├── models/registration_data.dart
│   ├── viewmodels/registration_view_model.dart
│   └── views/registration_page.dart
└── main.dart
```
- **Model**: cấu trúc dữ liệu đăng ký.
- **View**: hiển thị UI, nhận thao tác, validate form và chuyển dữ liệu.
- **ViewModel**: quản lý trạng thái gửi và kết quả.
- **Core**: tập trung quy tắc kiểm tra có thể tái sử dụng.

## Chạy trên Chrome
Cài Flutter SDK, bật Flutter Web, sau đó chạy:
```bash
flutter doctor
flutter config --enable-web
flutter pub get
flutter run -d chrome
```

## Bản demo chạy trên vercel
https://topic-06-week-13-hoangnd675.vercel.app

## Các nội dụng kiểm tra
1. Bấm đăng ký khi để trống: các trường bắt buộc hiển thị lỗi.
2. Nhập email sai, số điện thoại ngắn hoặc mật khẩu yếu: validator phản hồi cụ thể.
3. Nhập mật khẩu xác nhận không khớp: hiển thị lỗi.
4. Nhập đúng dữ liệu và đồng ý điều khoản: nhận thông báo đăng ký thành công.
5. Bấm "Làm mới biểu mẫu": xóa dữ liệu và trạng thái.
