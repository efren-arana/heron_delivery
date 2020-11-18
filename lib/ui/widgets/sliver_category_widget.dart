import 'package:flutter/material.dart';
import 'package:heron_delivery/core/constants/theme/text_styles.dart';
import 'package:heron_delivery/core/models/item_category_model.dart';
import 'package:heron_delivery/core/viewmodels/home_view_model.dart';
import 'package:heron_delivery/ui/shared/ui_helpers.dart';
import 'package:provider/provider.dart';

class SliverItemCategoryWidget extends StatelessWidget {
  SliverItemCategoryWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    List<ItemCategoryModel> categories;
    final categoryProvider = Provider.of<HomeViewModel>(context);
    return SliverToBoxAdapter(
        child: Container(
      width: double.infinity,
      height: _size.height * 0.15,
      child: StreamBuilder<List<ItemCategoryModel>>(
          stream: categoryProvider.fetchItemCategoryAsStream(),
          builder: (context, AsyncSnapshot<List<ItemCategoryModel>> snapshot) {
            if (snapshot.hasData) {
              categories = snapshot.data;
              return ListView.builder(
                physics:
                    BouncingScrollPhysics(), //para que el scroll sea igual que en android
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final cName = categories[index].name;

                  /// crear un widget que reciba los parametros y cree la categoria
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        _CategoryButton(categories[index]),
                        SizedBox(height: 10),
                        Text(
                          '${cName[0].toUpperCase()}${cName.substring(1)}',
                          style: subHeaderStyle,
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container(
                child: Center(child: loadProgress),
              );
            }
          }),
    ));
  }
}

class _CategoryButton extends StatelessWidget {
  final ItemCategoryModel categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    //obtengo la instancia del servicio para cambiar el color de la categoria
    final homeModelProvider = Provider.of<HomeViewModel>(context);

    return GestureDetector(
      onTap: () {
        final homeModelProvider =
            Provider.of<HomeViewModel>(context, listen: false);
        homeModelProvider.selectedCategory = categoria.name;
      },
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (homeModelProvider.selectedCategory == this.categoria.name)
                ? Colors.blueGrey[100]
                : Colors.white),
        child: Center(
          child: getIcon(categoria.name),
        ),
      ),
    );
  }
}
