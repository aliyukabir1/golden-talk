import 'package:email_validator/email_validator.dart';

class Validator {
  emailValidator(String? email) {
    if (!EmailValidator.validate(email!)) {
      return 'invalid email';
    }
  }

  inputValidator(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty';
    }
  }
}
