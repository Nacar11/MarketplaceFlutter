class MPValidator {
  static const String regexNoSpecialChars = r'^[a-zA-Z0-9\s]+$';
  static const String noWhitespace = r'^[^\s]+$';
  static const String noUnderscoreAtBeginning = r'^[^_].*$';
  static String? validateEmptyText(String? value, String fieldName) {
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

  static String? validateDescriptionLength(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    if (value.length < 16) {
      return '$fieldName must be at least 16 characters long.';
    }
    return null;
  }

  static String? validatePrice(String? value,
      {required double minimumPrice, double? maximumPrice}) {
    if (value == null) {
      return 'Price is required.';
    }

    if (value.isEmpty) {
      return 'Price is required.';
    }

    final price = double.tryParse(value);
    if (price == null || price < minimumPrice) {
      return 'Price must be at least Php ${minimumPrice.toStringAsFixed(0)}';
    }

    if (maximumPrice != null && price > maximumPrice) {
      return 'Price cannot exceed Php ${maximumPrice.toStringAsFixed(0)}';
    }

    return null;
  }
}
