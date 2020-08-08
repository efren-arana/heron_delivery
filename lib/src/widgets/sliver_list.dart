import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heron_delivery/src/models/shop_model.dart';
import 'package:heron_delivery/src/providers/shop_provider.dart';
import 'package:heron_delivery/src/services/news_service.dart';
import 'package:provider/provider.dart';

import 'lista_noticias.dart';

class SliverListWidget extends StatefulWidget {
  SliverListWidget({Key key}) : super(key: key);

  @override
  _SliverListWidgetState createState() => _SliverListWidgetState();
}

class _SliverListWidgetState extends State<SliverListWidget> {
  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopProvider>(context);
    final _screenSize = MediaQuery.of(context).size;

    return (!shopProvider.isLoading)
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Noticia(
                  noticia: shopProvider.getShopCategoriaSeleted[index],
                  index: index);
            }, childCount: shopProvider.getShopCategoriaSeleted.length),
          )
        : SliverFillRemaining(
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}
