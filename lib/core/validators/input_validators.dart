class InputValidators {
  InputValidators._();

  static String? required(String? value, {String fieldName = 'Trường này'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName không được để trống.';
    }
    return null;
  }

  static String? fullName(String? value) {
    final requiredError = required(value, fieldName: 'Họ và tên');
    if (requiredError != null) return requiredError;
    if (value!.trim().length < 2) return 'Họ tên phải có ít nhất 2 ký tự.';
    if (RegExp(r'[0-9]').hasMatch(value))
      return 'Họ tên không được chứa chữ số.';
    return null;
  }

  static String? email(String? value) {
    final requiredError = required(value, fieldName: 'Email');
    if (requiredError != null) return requiredError;
    final pattern = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]{2,}$');
    if (!pattern.hasMatch(value!.trim())) return 'Email chưa đúng định dạng.';
    return null;
  }

  static String? phone(String? value) {
    final requiredError = required(value, fieldName: 'Số điện thoại');
    if (requiredError != null) return requiredError;
    final digits = value!.replaceAll(RegExp(r'\D'), '');
    if (!RegExp(r'^(0|84)\d{9,10}$').hasMatch(digits)) {
      return 'Số điện thoại cần 10–11 chữ số, bắt đầu bằng 0 hoặc 84.';
    }
    return null;
  }

  static String? password(String? value) {
    final requiredError = required(value, fieldName: 'Mật khẩu');
    if (requiredError != null) return requiredError;
    if (value!.length < 8) return 'Mật khẩu phải có ít nhất 8 ký tự.';
    if (!RegExp(r'[A-Z]').hasMatch(value))
      return 'Cần ít nhất 1 chữ cái viết hoa.';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Cần ít nhất 1 chữ số.';
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final requiredError = required(value, fieldName: 'Xác nhận mật khẩu');
    if (requiredError != null) return requiredError;
    if (value != password) return 'Mật khẩu xác nhận không khớp.';
    return null;
  }
}
