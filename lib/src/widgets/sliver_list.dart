import 'dart:async';

import 'package:flutter/material.dart';
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
    final newsService = Provider.of<ShopProvider>(context);

    return (!newsService.isLoading)
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Noticia(
                  noticia: newsService.getShopCategoriaSeleted[index],
                  index: newsService.getShopCategoriaSeleted.length);
            }, childCount: 10),
          )
        : SliverToBoxAdapter(
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}
