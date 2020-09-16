import 'package:flutter/material.dart';

class OrderDetailView extends StatefulWidget {
  final dynamic value;
  final bool hasError;
  OrderDetailView({Key key, this.value,this.hasError = false}) : super(key: key);

  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  Object valor;
  dynamic exception;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: Text('message: \nError: ${widget.value.toString()}'
                    '\nData: ${widget.value.toString()}\n'
                    'Tiene error: ${widget.hasError}'))));
  }
}
