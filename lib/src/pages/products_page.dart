import 'package:flutter/material.dart';
import 'package:heron_delivery/src/models/product_model.dart';
import 'package:heron_delivery/src/models/shop_model.dart';
import 'package:heron_delivery/src/widgets/grid_product_widget.dart';
import 'package:provider/provider.dart';


class ProductPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final Shop shop = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: ( ) => print('FlatButton!!!!!!!'), 
          child: Text('Ver Canasta'))
      ],
      body: CustomScrollView(

        slivers: <Widget>[
          _crearAppBar(shop),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitulo(context, shop),
            _description(shop),
            
          ])),
          GridProductWidget()
        ],
      ),
    );
  }

  Widget _crearAppBar(Shop shop) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false, //permite mostrar el appbar al realizar el scroll
      pinned: true, // permite dejar un appBar normal
      flexibleSpace: FlexibleSpaceBar(
        title: Text(shop.name,
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
        centerTitle: true,
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(shop.imageUrl), //colacar la imagen de fonde de la tienda
          fit: BoxFit.cover,
          fadeInDuration: Duration(seconds: 1),
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Shop shop) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: <Widget>[
        Hero(
          tag: shop.shopId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image(
              image: NetworkImage(shop.logoUrl), //colocar el icono del restaurant
              height: 150.0,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Flexible(
            //widget que se adapta al espacio restante en la fila (Row)
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              shop.name,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              shop.description,
              style: Theme.of(context).textTheme.subtitle2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.star_half),
                SizedBox(
                  width: 5.0,
                ),
                Text(shop.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle2)
              ],
            )
          ],
        ))
      ]),
    );
  }

  Widget _description(Shop shop) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        shop.description,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
