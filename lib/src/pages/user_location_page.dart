import 'package:flutter/material.dart';

class UserLocation extends StatelessWidget {
  static final String routeName = 'user-location';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          'UserLocation  Page!!',
          style: TextStyle(fontSize: 50.0),
        ),
      ),
    );
  }
}
