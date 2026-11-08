# Topic 06 – Week 13 | Form Validation

Ứng dụng demo Flutter Web về **Biểu mẫu và kiểm tra dữ liệu đầu vào**, triển khai theo Clean Code và MVVM.

## Nội dung theo đề bài
- TextField / TextFormField: nhập họ tên, email, số điện thoại, mật khẩu.
- Form và GlobalKey<FormState>: quản lý và kiểm tra toàn bộ biểu mẫu.
- Validator: kiểm tra bắt buộc, định dạng email, số điện thoại, độ mạnh mật khẩu và xác nhận mật khẩu.
- TextEditingController: đọc và xóa dữ liệu nhập.
- FocusNode: chuyển focus giữa các trường.
- Phản hồi lỗi khi nhập; thông báo thành công khi dữ liệu hợp lệ.
- Minh họa dữ liệu hợp lệ, không hợp lệ và thao tác làm mới biểu mẫu.

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

Build bản web:
```bash
flutter build web --release
```
Thư mục triển khai: `build/web`.

## Kiểm tra chất lượng
```bash
dart format .
flutter analyze
flutter test
```

## Kịch bản demo
1. Bấm đăng ký khi để trống: các trường bắt buộc hiển thị lỗi.
2. Nhập email sai, số điện thoại ngắn hoặc mật khẩu yếu: validator phản hồi cụ thể.
3. Nhập mật khẩu xác nhận không khớp: hiển thị lỗi.
4. Nhập đúng dữ liệu và đồng ý điều khoản: nhận thông báo đăng ký thành công.
5. Bấm **Làm mới biểu mẫu**: xóa dữ liệu và trạng thái.

> Đây là demo frontend; thao tác gửi hiện mô phỏng bất đồng bộ, chưa kết nối backend/database.
