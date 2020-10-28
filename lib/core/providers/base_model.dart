import 'package:flutter/widgets.dart';


//TODO: Cambiar el tipo de la clase a una clase abstracta
//TODO: esta clase no tiene que ser instanciada
abstract class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }
}