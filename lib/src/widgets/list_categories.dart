import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heron_delivery/src/providers/category_provider.dart';
import 'package:heron_delivery/src/providers/shop_provider.dart';
import 'package:heron_delivery/src/utils/icono_string_util.dart';
import 'package:provider/provider.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;

class ListCategoryWidget extends StatefulWidget {
  ListCategoryWidget({Key key}) : super(key: key);

  @override
  _ListCategoryWidgetState createState() => _ListCategoryWidgetState();
}

class _ListCategoryWidgetState extends State<ListCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    List<Category> categories;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return SliverToBoxAdapter(
        child: Container(
      width: double.infinity,
      height: 100,
      child: StreamBuilder<QuerySnapshot>(
          stream: categoryProvider.fetchCategorysAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              categories = snapshot.data.documents
                  .map((doc) => Category.fromMap(doc.data, doc.documentID))
                  .toList();
              return ListView.builder(
                physics:
                    BouncingScrollPhysics(), //para que el scroll sea igual que en android
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final cName = categories[index].name;
                  /// crear un widget que reviba los parametros y cree la categoria
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        _CategoryButton(categories[index]),
                        SizedBox(height: 5),
                        Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                      ],
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    ));
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    //obtengo la instancia del servicio para cambiar el color de la categoria
    final shopProvider = Provider.of<ShopProvider>(context);

    return GestureDetector(
      onTap: () {
        // print('${ categoria.name }');
        //colocar el listen en false cuando el provider se encuentra en un tag
        final shopProvider = Provider.of<ShopProvider>(context, listen: false);
        shopProvider.selectedCategory = categoria.name;
      },
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, 
        color: (shopProvider.selectedCategory == this.categoria.name)?
          Color.fromRGBO(99, 101, 105, 1.0)
          : Colors.white),
        child: Center(
          child: getIcon(
            categoria.name,
            //(shopProvider.selectedCategory == this.categoria.name)
            //    ? color.getColorYellowRGBO()
            //    :
            Colors.blue,
          ),
        ),
      ),
    );
  }
}
