class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$',
    // r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static final RegExp _dateRegExp = RegExp(
    r'^([0-9]{4}[-](0[1-9]|1[0-2])[-]([0-2]{1}[0-9]{1}|3[0-1]{1})|([0-2]{1}[0-9]{1}|3[0-1]{1})[-](0[1-9]|1[0-2])[-][0-9]{4})',
  );

  static final RegExp _usernameAndGenderRegExp =
      RegExp(r'[a-zA-Z][a-zA-Z0-9-_]{3,32}');
  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isPasswordConfirmed(String password, String confirmPassword) {
    print(confirmPassword);
    print(password);
    return confirmPassword == password;
  }

  static isValidDate(String birthday) {
    return _dateRegExp.hasMatch(birthday);
  }

  static isValidAccountPicture(String picture) {
    return null;
  }

  static isValidUsernameAndGender(String usernameAndGender) {
    return _usernameAndGenderRegExp.hasMatch(usernameAndGender);
  }
}
