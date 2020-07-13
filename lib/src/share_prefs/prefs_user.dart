import 'package:shared_preferences/shared_preferences.dart';

class PrefsUser {
  static final PrefsUser _instancia = new PrefsUser._singleton();

  factory PrefsUser() {
    return _instancia;
  }
  PrefsUser._singleton();

  SharedPreferences prefs;

  initPrefs() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  //Setters and Getters de la preferencias
  //genero
  int get genero => prefs.getInt('genero') ?? 1;
  set genero(int value) => prefs.setInt('genero', value);

  //nombres
  String get nombre => prefs.getString('nombre') ?? '';
  set nombre(String value) => prefs.setString('nombre', value);

  //color
  bool get colorSecundario => prefs.getBool('colorSecundario') ?? false;
  set colorSecundario(bool value) => prefs.setBool('colorSecundario', value);

  //ultimaPagina
  String get ultimaPagina => prefs.getString('ultimaPagina') ?? 'home';
  set ultimaPagina(String value) => prefs.setString('ultimaPagina', value);
}
