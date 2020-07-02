import 'dart:async';

import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListaPage> {
  //controlador del scrooll de la lista
  ScrollController _scrollController = new ScrollController();
  List<int> _listNumbers = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addNumber();

    _scrollController.addListener(() {
      //print('SCROLL!!');
      //validamos si estamos al final de la pagina
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //_addNumber();
        _fechData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[_crearList(), _crearLoading()],
    );
  }

  _crearList() {
    return RefreshIndicator(
      onRefresh: _obtenerPagina1, //solo paso la referencia
      child: ListView.builder(
          controller: _scrollController,
          itemCount: _listNumbers.length,
          itemBuilder: (BuildContext context, int index) {
            final listNumber = _listNumbers[index];

            return FadeInImage(
              placeholder: AssetImage('assets/images/jar-loading.gif'),
              image: NetworkImage(
                  'https://picsum.photos/200/300?image=$listNumber'),
              fit: BoxFit.fitHeight,
              fadeInCurve: Curves.easeIn,
            );
          }),
    );
  }

  void _addNumber() {
    for (var i = 0; i < 10; i++) {
      _ultimoItem++;

      _listNumbers.add(_ultimoItem);

      setState(() {});
    }
  }

  Future<Null> _fechData() async {
    _isLoading = true;

    setState(() {});
    final duration = new Duration(milliseconds: 2000);
    return new Timer(duration, _respuestaHttp);
  }

  _respuestaHttp() {
    _isLoading = false;

    _scrollController.animateTo(_scrollController.position.pixels + 200,
        duration: new Duration(seconds: 2), curve: Curves.fastOutSlowIn);

    _addNumber();
  }

  Widget _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Future<Null> _obtenerPagina1() async {
    final duration = new Duration(milliseconds: 2000);
    new Timer(duration, () {
      _listNumbers.clear();
      _ultimoItem++;
      _addNumber();
    });

    return Future.delayed(duration);
  }
}
