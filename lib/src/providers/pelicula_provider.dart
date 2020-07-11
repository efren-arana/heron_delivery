import 'dart:async';
import 'dart:convert';

import 'package:heron_delivery/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculaProvider {
  String _apiKey = 'd0a72b0d2656413987278d327dacd589';
  String _domain = 'api.themoviedb.org';
  String _language = 'es-ES';
  bool _cargando = false;
  int _popularesPage = 0;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  //introducir y escuchar datos a nuestro Stream
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void dispose() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    String _resource = '3/movie/now_playing';

    final url = Uri.https(
        _domain, _resource, {'api_key': _apiKey, 'language': _language});
    print('getEnCines() Ejecutada !!!');

    return await this._httpGet(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    String _resource = '3/movie/popular';
    //if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_domain, _resource, {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    //
    final resp = await this._httpGet(url);
    print('getPopulares( ) Ejecutada !!!');

    _populares.addAll(resp);

    //agrego peliculas a mi stream
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Pelicula>> searchMovie(String query) async {
    String _resource = '3/search/movie';

    final url = Uri.https(_domain, _resource,
        {'api_key': _apiKey, 'language': _language, 'query': query});
    print('3/search/movie');
    return await this._httpGet(url);
  }

  Future<List<Pelicula>> _httpGet(Uri url) async {
    final response = await http.get(url);

    final jsonMap = json.decode(response.body);
    //retorno una lista de pelicula List<Pelicula> items
    return Peliculas.fromJsonList(jsonMap['results']).items;
  }
}
