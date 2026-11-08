class RegistrationData {
  const RegistrationData({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.acceptedTerms,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final bool acceptedTerms;
}
