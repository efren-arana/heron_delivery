import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/src/models/category_model.dart';
import 'package:heron_delivery/src/models/news_models.dart';

import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = 'd357edafe4ad4641bb7dc29b21e0f91b';

/// Clase provider que notifica a todos los que estan suscriptos.
class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  //mapa que almacena la lista de las categorias.
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    //this.getTopHeadlines();

    //inicializo el mapa con la lista de categorias
    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });

    this.getArticlesByCategory(this._selectedCategory);
  }

  bool get isLoading => this._isLoading;

  /// setter and getter selected category
  get selectedCategory => this._selectedCategory;
  /// seteo la categoria seleccionada
  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory(valor);
    notifyListeners(); //notifica a todos los que estan escuchando el provider
  }

  ///  obtengo la lista de noticias segun la categoria seleccionada
  List<Article> get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url =
        '$_URL_NEWS/top-headlines?category=business&apiKey=$_APIKEY&country=us';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    //agrego todos los articulos
    //agrego una lista a otra lista
    this.headlines.addAll(newsResponse.articles);
    notifyListeners(); //notifico a los que estan escuchando este provider
  }

  /// obtengo la lista de las noticias por categoria
  getArticlesByCategory(String category) async {
    //valido si ya existe informacion en el mapa
    if (this.categoryArticles[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }

    if (category == null) {
      category = 'business';
    }
    final url =
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    //almacenar la respuesta de las noticias por categoria en el mapa
    this.categoryArticles[category].addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }
}
