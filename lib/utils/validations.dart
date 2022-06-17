class EmailFieldValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return '*Required';
    } else if (value.isValidEmail()) {
      return null;
    }
    return "*Invalid Email Address";
  }
}

class PasswordFieldValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return '*Required';
    } else if (value.length < 6) {
      return "*Invalid Password";
    }
    return null;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
