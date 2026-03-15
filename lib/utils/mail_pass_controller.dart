class Utils {
  static bool isEmail(String email) {
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return regex.hasMatch(email);
  }

  static bool isStrongPassword(String password) {
    final regex =
    RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }
}