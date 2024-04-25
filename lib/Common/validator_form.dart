class FormValidator {
  //! Email Regex
  static var emailReg = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\s'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])\s+)\])';

  static var nameReg = r'[!@#<>?":_`~;[\]\\|=+)(*&^%\0-9-]';

  //! String for Form

  static String txtMail = "Please enter email";
  static String txtValidMail = "Please enter a valid email address";
  static String txtPhoneNumber = "Please enter phone number";
  static String txtValidPhoneNumber = "Please enter a valid number";
  static String txtVerificationCode = "Please enter verification code";
  static String txtValidVerificationCode =
      "Please enter valid verification code";
  static String txtName = "Please enter name";
}
