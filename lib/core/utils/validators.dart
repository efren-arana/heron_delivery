class Validators {

  /// Metodo que valida el formato del numero
  dynamic validatePhoneNumber(phone) {
    //TODO: valido el formato del numero
    //TODO: agrego el codigo de area del pais
    return '+593' + phone;
  }

  ///metodo que realiza las validacion de la contrasena
  String validatePwd(value) {
    if (value.toString().isEmpty) {
      return 'Campo obligatorio';
    } else if (value.toString().length < 6) {
      return 'Minimo 6 caracteres';
    } else if (value.toString().length > 15) {
      return 'Maximo 15 caracteres';
    } else {
      return null;
    }
  }

  ///Valida el patron del email
  String validateEmail(email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern); //expresion regular

    if (regExp.hasMatch(email)) {
      return null;
    } else {
      return 'Email no es correcto';
    }
  }

  /// This will work with names starting with both lower- and upper-cased letters.
  /// ^ - start of string
  /// [a-zA-Z]{4,} - 4 or more ASCII letters
  /// (?: [a-zA-Z]+){0,2} - 0 to 2 occurrences of a space followed with one or more ASCII letters
  /// $ - end of string.
  String validateFullName(fullName) {
    Pattern pattern = r'^[a-zA-Z]{4,}(?: [a-zA-Z]+){1,2}$';
    RegExp regExp = new RegExp(pattern); //expresion regular

    if (regExp.hasMatch(fullName)) {
      return null;
    } else {
      return 'El nombre no es correcto';
    }
  }
}
