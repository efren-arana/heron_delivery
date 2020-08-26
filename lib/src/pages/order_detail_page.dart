import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  final dynamic value;
  final bool hasError;
  OrderDetailPage({Key key, this.value,this.hasError = false}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
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
