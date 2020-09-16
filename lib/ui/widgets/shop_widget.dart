import 'package:flutter/material.dart';
import 'package:heron_delivery/core/models/shop_model.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart';


class CardShopWidget extends StatelessWidget {
  final Shop noticia;
  final int index;

  const CardShopWidget({@required this.noticia, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(noticia, index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        _TarjetaBotones(),
        SizedBox(height: 10),
        Divider(),
        Card(child: ListTile(title: Text('data'),),),
        Card(child: ListTile(title: Text('data'),),),
        Card(child: ListTile(title: Text('data'),),),
        Card(child: ListTile(title: Text('data'),),)
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            fillColor: miTema.accentColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Shop noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text((noticia.description != null) ? noticia.description : ''));
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Shop noticia;

  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Hero(
        tag: noticia.shopId,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/items',arguments: noticia),
            child: Container(
                child: (noticia.imageUrl != null)
                    ? FadeInImage(
                        placeholder: AssetImage('assets/img/giphy.gif'),
                        image: NetworkImage(noticia.imageUrl))
                    : Image(
                        image: AssetImage('assets/img/no-image.png'),
                      )),
          ),
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Shop noticia;

  const _TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.name,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Shop noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: TextStyle(color: miTema.accentColor),
          ),
          Text('${noticia.name}. '),
        ],
      ),
    );
  }
}
