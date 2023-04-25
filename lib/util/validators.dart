class Validators {
  static bool emptyString(String text) {
    return text.isEmpty;
  }

  static bool isEmailString(String text) {
    const String emailRegExp =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$";

    return RegExp(emailRegExp).hasMatch(text);
  }

  static bool hasUpperLetters(String text) {
    const String uppercaseRequired = '.*[A-Z].*';

    return RegExp(uppercaseRequired).hasMatch(text);
  }

  static bool haslowerLetters(String text) {
    const String uppercaseRequired = '.*[a-z].*';

    return RegExp(uppercaseRequired).hasMatch(text);
  }

  static bool hasNumbers(String text) {
    const String numberRequired = '.*[0-9].*';

    return RegExp(numberRequired).hasMatch(text);
  }

  static bool hasSpecialCharacters(String text) {
    const String charactersRequired = r'.*[-=!@#$%^&*(),.?":{}|<>].*';

    return RegExp(charactersRequired).hasMatch(text);
  }

  static bool isAlphanumeric(String text) {
    const String alphanumericRequired = r'^[a-zA-Z0-9áéíóúàèìòùâêôãõüñ ]*$';

    return RegExp(alphanumericRequired).hasMatch(text.toLowerCase());
  }

  static bool isNameOrLastname(String text) {
    List<String> parts = text.split(' ');

    return parts.fold(true, (valid, part) => valid && (isAlphanumeric(part)));
  }

  static bool isPhoneNumber(String text) {
    const String alphanumericRequired = r'^[0-9]*$';

    return RegExp(alphanumericRequired).hasMatch(text);
  }

  static bool isCURP(String text) {
    const String regexRequired =
        r'^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$';

    return RegExp(regexRequired).hasMatch(text);
  }

  /// Calcule if have at least 'years' old
  static bool haveAtLeast(int years, DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }

    return age >= years;
  }
}
