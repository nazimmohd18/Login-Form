import 'package:flutter_test/flutter_test.dart';
import 'package:login_form/utils/validations.dart';

void main() {
  test('empty email returns error string', () {
    var result = EmailFieldValidator.validate('');
    expect(result, "*Required");
  });

  test('invalid email returns error string', () {
    var result = EmailFieldValidator.validate('email.com');
    expect(result, "*Invalid Email Address");
  });

  test('valid email returns null', () {
    var result = EmailFieldValidator.validate('nazim@gmail.com');
    expect(result, null);
  });

  test('empty password returns error string', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, "*Required");
  });

  test('non-empty password returns null', () {
    var result = PasswordFieldValidator.validate('Nazim@123');
    expect(result, null);
  });
}
