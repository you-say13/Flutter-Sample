import 'package:flutter/cupertino.dart';
import 'package:riverpod_sample/l10n/l10n.dart';

enum ErrorCategory {
  empty,
  length,
  format,
  none,
}

class ErrorUser {
  ErrorUser({
    required this.nameError,
    required this.userNameError,
    required this.emailError,
    required this.zipCodeError,
    required this.suiteError,
    required this.streetError,
    required this.cityError,
    required this.phoneError,
    required this.webSiteError,
    required this.companyNameError,
  });

  late final ErrorCategory nameError;
  late final ErrorCategory userNameError;
  late final ErrorCategory emailError;
  late final ErrorCategory zipCodeError;
  late final ErrorCategory suiteError;
  late final ErrorCategory streetError;
  late final ErrorCategory cityError;
  late final ErrorCategory phoneError;
  late final ErrorCategory webSiteError;
  late final ErrorCategory companyNameError;
}

class Validator {
  final defaultMinLength = 1;
  final defaultMinEmailLength = 5;
  final defaultMaxLength = 16;
  final defaultMaxEmailLength = 32;

  final emailValidationPattern = '^[A-Za-z0-9 -/:-@[-´{-~]+@[A-Za-z0-9]+.[A-Za-z0-9]+\$';

  ErrorCategory defaultValidator(String? value) {
    debugPrint("default validating");

    if (value == null || value.isEmpty) return ErrorCategory.empty;
    if (defaultMinLength > value.length || value.length > defaultMaxLength) {
      return ErrorCategory.length;
    }
    return ErrorCategory.none;
  }

  ErrorCategory emailValidator(String? value) {
    debugPrint("email validating");

    if (value == null || value.isEmpty) return ErrorCategory.empty;
    if (defaultMinEmailLength > value.length || value.length > defaultMaxEmailLength) {
      return ErrorCategory.length;
    }
    if (RegExp(emailValidationPattern).hasMatch(value)) {
      return ErrorCategory.none;
    }
    return ErrorCategory.format;
  }
}

class InputValidator {
  String? errorString({required String key, String? value, required BuildContext context}) {
    final l10n = L10n.of(context)!;

    final isEmpty = Validator().defaultValidator(value) == ErrorCategory.empty;
    final isFormat = Validator().defaultValidator(value) == ErrorCategory.format;
    final isLength = Validator().defaultValidator(value) == ErrorCategory.length;
    switch (key) {
      case "name":
        if (isEmpty) {
          return l10n.defaultRequiredError;
        } else if (isFormat) {
          return l10n.nameError;
        } else if (isLength) {
          return l10n.defaultLengthError;
        }
        return null;
      case "username":
        if (isEmpty) {
          return l10n.defaultRequiredError;
        } else if (isFormat) {
          return l10n.userNameError;
        } else if (isLength) {
          return l10n.defaultLengthError;
        }
        return null;
      case "city":
        if (isEmpty) {
          return l10n.defaultRequiredError;
        } else if (isFormat) {
          return l10n.cityError;
        } else if (isLength) {
          return l10n.defaultLengthError;
        }
        return null;
      case "suite":
        if (isEmpty) {
          return l10n.defaultRequiredError;
        } else if (isFormat) {
          return l10n.suiteError;
        } else if (isLength) {
          return l10n.defaultLengthError;
        }
        return null;
      case "street":
        if (isEmpty) {
          return l10n.defaultRequiredError;
        } else if (isFormat) {
          return l10n.streetError;
        } else if (isLength) {
          return l10n.defaultLengthError;
        }
        return null;
      case "companyName":
        if (isEmpty) {
          return l10n.defaultRequiredError;
        } else if (isFormat) {
          return l10n.companyNameError;
        } else if (isLength) {
          return l10n.defaultLengthError;
        }
        return null;
      case "phone":
        if (isEmpty) {
          return l10n.defaultRequiredError;
        } else if (isFormat) {
          return l10n.phoneError;
        } else if (isLength) {
          return l10n.defaultLengthError;
        }
        return null;
      case "email":
        if (Validator().emailValidator(value) == ErrorCategory.empty) {
          return l10n.defaultRequiredError;
        } else if (Validator().emailValidator(value) == ErrorCategory.format) {
          return l10n.emailError;
        } else if (Validator().emailValidator(value) == ErrorCategory.length) {
          return l10n.emailLengthError;
        }
        return null;
    }
  }
}
