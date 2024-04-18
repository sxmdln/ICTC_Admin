import 'package:email_validator/email_validator.dart';

class Validators {
  static String? hasValue(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be left blank!";
    }
    return null;
  }


  static String? isAnEmail(String? value) {
    if (value != null ? !EmailValidator.validate(value) : true) {
      return "Invalid email!";
    }
    return null;
  }
}