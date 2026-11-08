import 'package:flutter/foundation.dart';
import '../models/registration_data.dart';

class RegistrationViewModel extends ChangeNotifier {
  bool _isSubmitting = false;
  RegistrationData? _submittedData;
  String? _statusMessage;

  bool get isSubmitting => _isSubmitting;
  RegistrationData? get submittedData => _submittedData;
  String? get statusMessage => _statusMessage;

  Future<bool> submit(RegistrationData data) async {
    if (_isSubmitting) return false;
    _isSubmitting = true;
    _statusMessage = null;
    notifyListeners();

    // Mô phỏng request bất đồng bộ. Thay bằng Repository/API khi tích hợp backend.
    await Future<void>.delayed(const Duration(milliseconds: 650));

    _submittedData = data;
    _statusMessage = 'Đăng ký thành công! Dữ liệu đã vượt qua các quy tắc kiểm tra.';
    _isSubmitting = false;
    notifyListeners();
    return true;
  }

  void clearStatus() {
    _statusMessage = null;
    _submittedData = null;
    notifyListeners();
  }
}
