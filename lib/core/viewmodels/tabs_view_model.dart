import 'package:flutter/material.dart';
import 'package:heron_delivery/core/providers/base_model.dart';

class TabViewModel extends BaseModel {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    if (this.paginaActual == valor) return;
    this._paginaActual = valor;

    //_pageController.animateToPage(valor,
    //    duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic);
    //notifico cuado se realice un cambio en el valor
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
