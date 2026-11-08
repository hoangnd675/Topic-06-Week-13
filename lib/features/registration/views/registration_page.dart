import 'package:flutter/material.dart';
import '../models/registration_data.dart';
import '../viewmodels/registration_view_model.dart';
import '../../../core/validators/input_validators.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _viewModel = RegistrationViewModel();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();

  String _role = 'Sinh viên';
  bool _acceptedTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _viewModel.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đồng ý với điều khoản để tiếp tục.')),
      );
      return;
    }

    final data = RegistrationData(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
      role: _role,
      acceptedTerms: _acceptedTerms,
    );
    await _viewModel.submit(data);
  }

  void _reset() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _confirmController.clear();
    setState(() {
      _role = 'Sinh viên';
      _acceptedTerms = false;
      _obscurePassword = true;
      _obscureConfirm = true;
    });
    _viewModel.clearStatus();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 700;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 18 : 32,
              vertical: 28,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: compact
                  ? _buildContent(context, true)
                  : _buildContent(context, false),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool compact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopBar(),
        const SizedBox(height: 28),
        if (compact)
          Column(
            children: [
              _buildIntro(),
              const SizedBox(height: 24),
              _buildFormCard(),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(right: 42, top: 26),
                  child: _buildIntro(),
                ),
              ),
              Expanded(flex: 6, child: _buildFormCard()),
            ],
          ),
        const SizedBox(height: 24),
        _buildFooter(),
      ],
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFEAE9FF),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.fact_check_rounded,
            color: Color(0xFF635BFF),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'FLUTTER LAB  /  TOPIC 06',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF6B6E80),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE9F8F0),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Row(
            children: [
              Icon(Icons.circle, size: 7, color: Color(0xFF20A66A)),
              SizedBox(width: 7),
              Text(
                'LIVE DEMO',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF168653),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIntro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFFEAE9FF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'CLEAN CODE  •  MVVM',
            style: TextStyle(
              color: Color(0xFF554DE0),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Biểu mẫu &\nkiểm tra dữ liệu',
          style: TextStyle(
            fontSize: 38,
            height: 1.12,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.3,
            color: Color(0xFF171A2B),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Xây dựng biểu mẫu đăng ký với quy tắc xác thực rõ ràng, phản hồi tức thì và trải nghiệm nhập liệu thân thiện.',
          style: TextStyle(
            fontSize: 15,
            height: 1.7,
            color: Color(0xFF73778A),
          ),
        ),
        const SizedBox(height: 28),
        _feature(
          Icons.widgets_outlined,
          'TextField & TextFormField',
          'Nhập liệu và hiển thị lỗi theo từng trường.',
        ),
        _feature(
          Icons.verified_user_outlined,
          'Validator & FormState',
          'Kiểm tra dữ liệu trước khi gửi biểu mẫu.',
        ),
        _feature(
          Icons.key_outlined,
          'GlobalKey & FocusNode',
          'Quản lý trạng thái form và điều hướng focus.',
        ),
        _feature(
          Icons.layers_outlined,
          'MVVM Architecture',
          'Tách View, ViewModel và Model độc lập.',
        ),
      ],
    );
  }

  Widget _feature(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF635BFF), size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292D40),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Color(0xFF85899A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D20264A),
            blurRadius: 35,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tạo tài khoản',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: Color(0xFF202337),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Điền thông tin bên dưới để trải nghiệm kiểm tra dữ liệu.',
              style: TextStyle(fontSize: 13, color: Color(0xFF85899A)),
            ),
            const SizedBox(height: 24),
            _label('Họ và tên'),
            TextFormField(
              controller: _nameController,
              focusNode: _nameFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _emailFocus.requestFocus(),
              decoration: _decoration('Nguyễn Văn An', Icons.person_outline),
              validator: InputValidators.fullName,
            ),
            const SizedBox(height: 16),
            _label('Email'),
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _phoneFocus.requestFocus(),
              decoration: _decoration('name@example.com', Icons.mail_outline),
              validator: InputValidators.email,
            ),
            const SizedBox(height: 16),
            _label('Số điện thoại'),
            TextFormField(
              controller: _phoneController,
              focusNode: _phoneFocus,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
              decoration: _decoration('0912 345 678', Icons.phone_outlined),
              validator: InputValidators.phone,
            ),
            const SizedBox(height: 16),
            _label('Vai trò'),
            DropdownButtonFormField<String>(
              value: _role,
              decoration: _decoration('Chọn vai trò', Icons.badge_outlined),
              items: const ['Sinh viên', 'Giảng viên', 'Khách mời']
                  .map(
                    (role) => DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _role = value ?? 'Sinh viên'),
            ),
            const SizedBox(height: 16),
            _label('Mật khẩu'),
            TextFormField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.next,
              decoration: _decoration(
                'Tối thiểu 8 ký tự',
                Icons.lock_outline,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => setState(
                    () => _obscurePassword = !_obscurePassword,
                  ),
                ),
              ),
              validator: InputValidators.password,
            ),
            const SizedBox(height: 16),
            _label('Xác nhận mật khẩu'),
            TextFormField(
              controller: _confirmController,
              obscureText: _obscureConfirm,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              decoration: _decoration(
                'Nhập lại mật khẩu',
                Icons.lock_reset_outlined,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => setState(
                    () => _obscureConfirm = !_obscureConfirm,
                  ),
                ),
              ),
              validator: (value) => InputValidators.confirmPassword(
                value,
                _passwordController.text,
              ),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: _acceptedTerms,
              onChanged: (value) =>
                  setState(() => _acceptedTerms = value ?? false),
              title: const Text(
                'Tôi đồng ý với điều khoản sử dụng.',
                style: TextStyle(fontSize: 12, color: Color(0xFF666B7D)),
              ),
            ),
            const SizedBox(height: 12),
            ListenableBuilder(
              listenable: _viewModel,
              builder: (context, _) => Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _viewModel.isSubmitting ? null : _submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF635BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _viewModel.isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Kiểm tra & đăng ký',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded, size: 18),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text('Làm mới biểu mẫu'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF62677A),
                        side: const BorderSide(color: Color(0xFFE5E7EF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  if (_viewModel.statusMessage != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF8F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF15945B),
                            size: 19,
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              _viewModel.statusMessage!,
                              style: const TextStyle(
                                color: Color(0xFF16794E),
                                fontSize: 13,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF34384B),
          ),
        ),
      );

  InputDecoration _decoration(String hint, IconData icon) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: Color(0xFFB0B3C0),
        ),
        prefixIcon: Icon(
          icon,
          size: 19,
          color: const Color(0xFF969AAC),
        ),
      );

  Widget _buildFooter() {
    return const Center(
      child: Text(
        'TOPIC 06  •  FORM VALIDATION  •  FLUTTER + DART',
        style: TextStyle(
          fontSize: 10,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
          color: Color(0xFF9A9EAD),
        ),
      ),
    );
  }
}
