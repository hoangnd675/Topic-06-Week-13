import 'package:flutter_test/flutter_test.dart';
import 'package:topic_06_week_13/core/validators/input_validators.dart';

void main() {
  group('InputValidators', () {
    test('rejects empty full name', () {
      expect(InputValidators.fullName(' '), isNotNull);
    });

    test('accepts a valid full name', () {
      expect(InputValidators.fullName('Nguyen Van An'), isNull);
    });

    test('rejects malformed email', () {
      expect(InputValidators.email('hello-at-mail'), isNotNull);
    });

    test('accepts valid email', () {
      expect(InputValidators.email('hello@example.com'), isNull);
    });

    test('rejects invalid phone number', () {
      expect(InputValidators.phone('12345'), isNotNull);
    });

    test('rejects weak password', () {
      expect(InputValidators.password('password'), isNotNull);
    });

    test('accepts strong password', () {
      expect(InputValidators.password('Password123'), isNull);
    });

    test('checks password confirmation', () {
      expect(InputValidators.confirmPassword('Password123', 'Password123'), isNull);
      expect(InputValidators.confirmPassword('Other1234', 'Password123'), isNotNull);
    });
  });
}
