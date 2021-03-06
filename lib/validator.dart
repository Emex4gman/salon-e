class Validator {
  static String? validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value!))
      return 'Please enter a valid email address.';
    else
      return null;
  }

  static String? validateOtp(String? value) {
    if (value!.length < 4)
      return 'Please enter a valid email address.';
    else
      return null;
  }

  static String? validatePassword(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }
}
