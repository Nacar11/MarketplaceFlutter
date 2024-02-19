class MPValidator {
  static const String regexNoSpecialChars = r'^[a-zA-Z0-9\s]+$';
  static const String noWhitespace = r'^[^\s]+$';
  static const String noUnderscoreAtBeginning = r'^[^_].*$';
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validateNames(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    if (!RegExp(regexNoSpecialChars).hasMatch(value)) {
      return '$fieldName should not contain special characters.';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    RegExp oneNumber = RegExp(r'^[a-zA-Z0-9]*\d+[a-zA-Z0-9]*$');

    if (value == null || value.isEmpty) {
      return 'Username is required';
    } else if (!RegExp(regexNoSpecialChars).hasMatch(value)) {
      return 'Username should not have special characters';
    } else if (value.length < 6) {
      return 'Username should be at least 6 characters';
    } else if (!oneNumber.hasMatch(value)) {
      return 'Username must contain at least one number';
    } else if (!RegExp(noWhitespace).hasMatch(value)) {
      return 'Username should not contain whitespaces';
    }
    return null;
  }
}
