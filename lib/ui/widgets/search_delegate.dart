/*import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;

class DataSearch extends SearchDelegate {
  PeliculaProvider _peliculasProvider = new PeliculaProvider();
  dynamic sugerencia;
  dynamic results;
  String auxQuery = '';
//propiedades de searchDelegate
  String searchFieldLabel = 'Busca lo que necesites';

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null); //si se cumple la condicion lanza un error
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    //copyWith()Crea una copia de este tema pero con los campos dados reemplazados por los nuevos valores.
    return theme.copyWith(
      primaryColor: color.getColorYellowRGBO(),
      primaryIconTheme:
          theme.primaryIconTheme.copyWith(color: color.getColorGrisRGBO()),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda de nuestro AppBar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  Widget myDetailsContainer1(Pelicula pelicula) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Candy Bliss",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                "4.3",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star_half,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                  child: Text(
                "(321) \u00B7 0.9 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
        Container(
            child: Text(
          "Pastries \u00B7 Phoenix,AZ",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FlatButton.icon(
                icon: Icon(Icons.local_grocery_store),
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: color.getColorYellowHex(),
                onPressed: () {},
                label: Container(
                    child: Text('Agregar',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)))))
      ],
    );
  }

  Widget myDetailsContainer2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Chocolate Haven",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Text(
                "4.3",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star_half,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                  child: Text(
                "(75) \u00B7 1.2 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
        Container(
            child: Text(
          "Pastries \u00B7 Phoenix,AZ",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
    );
  }

  Widget myDetailsContainer3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Cake Walk",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Text(
                "4.0",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star_half,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                  child: Text(
                "(100) \u00B7 2.0 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
        Container(
            child: Text(
          "Pastries \u00B7 Phoenix,AZ",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
    );
  }

  Widget myDetailsContainer4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Chocolate Bar",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Text(
                "3.5",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star_half,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                  child: Text(
                "(50) \u00B7 2.5 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
        Container(
            child: Text(
          "Pastries \u00B7 Phoenix,AZ",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
    );
  }

  FutureBuilder<List<Pelicula>> obtieneResults() {
    return results = FutureBuilder(
      future: _peliculasProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        final categorias = snapshot.data;

        if (snapshot.hasData) {
          return ListView(
            children: categorias.map((pelicula) {
              pelicula.uniqueId = '${pelicula.id}-serch';
              return Hero(
                  tag: pelicula.uniqueId,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Container search!!! ${pelicula.originalTitle}');
                      },
                      child: Container(
                        child: FittedBox(
                          child: Material(
                            color: Colors.white,
                            elevation: 14.0,
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 180.0,
                                  width: 200.0,
                                  child: ClipRRect(
                                    borderRadius:
                                        new BorderRadius.circular(24.0),
                                    child: FadeInImage(
                                      alignment: Alignment.topLeft,
                                      placeholder:
                                          AssetImage('assets/img/no-image.jpg'),
                                      image:
                                          NetworkImage(pelicula.getPosterImg()),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: myDetailsContainer1(pelicula),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder que crea los resultados a mostrar
    //dynamic auxQuery;
    if (query.isEmpty) {
      return buildSuggestions(context);
    }

    //falta controlar que se no se recargue la busqueda cuando existe una lista
    return results;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugenrencias (peticion AJAX)

    //Corregir al seleccion el campo de busqueda se ejecuta la peticion para obtener resultados

    if (query.isNotEmpty) {
      return obtieneResults();
    }

    if (sugerencia != null && query.isEmpty) {
      return sugerencia;
    }

    return sugerencia = FutureBuilder(
      future: _peliculasProvider.getPopulares(),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        final categorias = snapshot.data;

        if (snapshot.hasData) {
          return ListView(
            children: categorias.map((pelicula) {
              pelicula.uniqueId = '${pelicula.id}-serch';
              return Hero(
                  tag: pelicula.uniqueId,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        query = pelicula
                            .title; //enviar el query de consulta de la categoria
                      },
                      child: Container(
                        child: FittedBox(
                          child: Material(
                            color: Colors.white,
                            elevation: 14.0,
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  height: 150.0,
                                  width: 400.0,
                                  child: ClipRRect(
                                    borderRadius:
                                        new BorderRadius.circular(24.0),
                                    child: FadeInImage(
                                      //alignment: Alignment.topCenter,
                                      placeholder:
                                          AssetImage('assets/img/no-image.jpg'),
                                      image:
                                          NetworkImage(pelicula.getPosterImg()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${pelicula.genreIds}', //nombre de la categoria
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 30.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  /*
    @override
    Widget buildSuggestions(BuildContext context) {
    // Sugenrencias (peticion AJAX)

    final listaSugerida = (query.isEmpty) ? 
                          peliculasRecientes : 
                          categorias.where(
                            (element) => element.toString().toLowerCase().startsWith(query.toLowerCase())
                            ).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      },
      );
  }
  */

}
*/