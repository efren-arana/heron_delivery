import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  List peliculas = [
    'Spiderman',
    'Batman',
    'Deadpool',
    'Superman',
    'Ironman',
    'Ironman 1',
    'Ironman 2',
    'Ironman 3',
  ];

  List peliculasRecientes = ['Acuaman', 'End Game Vengadores', 'WonderWoman'];

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

  @override
  Widget buildResults(BuildContext context) {
    // Builder que crea los resultados a mostrar
    return Center(
        child: Container(
      height: 150.0,
      width: 150.0,
      color: Colors.blueAccent,
      child: Text(seleccion),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugenrencias (peticion AJAX)

    if (query.isEmpty) {
      return Container();
    }

    return Container();
  }

  /*
    @override
    Widget buildSuggestions(BuildContext context) {
    // Sugenrencias (peticion AJAX)

    final listaSugerida = (query.isEmpty) ? 
                          peliculasRecientes : 
                          peliculas.where(
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
