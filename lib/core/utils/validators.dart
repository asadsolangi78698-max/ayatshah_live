class Validators {
  Validators._();

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    final regex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid phone number';
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter the OTP';
    if (value.trim().length != 6) return 'OTP must be 6 digits';
    return null;
  }

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? bio(String? value) {
    if (value != null && value.length > 150) {
      return 'Bio must be under 150 characters';
    }
    return null;
  }
}
