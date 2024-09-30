class Validator {
  final defaultMinLength = 1;
  final defaultMinEmailLength = 5;
  final defaultMaxLength = 16;
  final defaultMaxEmailLength = 32;

  final emailValidationPattern = '^[A-Za-z0-9]+@[A-Za-z0-9]+.[A-Za-z0-9]+\$';

  bool defaultValidator(String? value) {
    if (value == null) return false;
    if (defaultMinLength > value.length || value.length < defaultMaxLength) {
      return true;
    }
    return false;
  }

  bool emailValidator(String? value) {
    if (value == null) return false;
    if (defaultMinEmailLength > value.length || value.length < defaultMaxEmailLength) {
      return true;
    }
    return !RegExp(emailValidationPattern).hasMatch(value);
  }
}
