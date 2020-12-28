import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:heron_delivery/core/viewmodels/auth_phone_view_model.dart';
import 'package:heron_delivery/core/viewmodels/make_order_view_model.dart';
import 'package:provider/provider.dart';


class MakeOrderView extends StatefulWidget {
  const MakeOrderView({Key key}) : super(key: key);

  @override
  _MakeOrderViewState createState() => _MakeOrderViewState();
}

class _MakeOrderViewState extends State<MakeOrderView> {
  String latitud = "";
  String longitud = "";
  bool _myLocation = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MakeOrderViewModel(),
        builder:(context,child) => Scaffold(
          appBar: AppBar(),
          body: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => Provider.of<MakeOrderViewModel>(context,listen: false)
                        .navigateToAuthPhoneView(),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                    BorderSide(color: Colors.grey[200])),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: "Mobile Number"),
                      ),
                    ),
                    Container(
                      child: IconButton(
                          icon: FaIcon(
                            Icons.my_location,
                            color: (_myLocation) ? Colors.blue : null,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_myLocation) {
                                _myLocation = false;
                                latitud = "";
                                longitud = "";
                              } else {
                                _myLocation = true;
                                getCurrentLocation();
                              }
                            });
                          }),
                    ),
                    Text("Latitud: " + '$latitud'),
                    Text("Longitud: " + '$longitud')
                  ],
                ),
              ),
            ),
          floatingActionButton: FloatingActionButton(onPressed: () => Provider.of<MakeOrderViewModel>(context,listen: false)
            .makeOrder()),
        ));
  }

  void getCurrentLocation() async {
    final location = await Geolocator.getCurrentPosition();
    //TODO: Realizar las validaciones si se permite acceder a los datos de ubicacion
    setState(() {
      latitud = location.latitude.toString();
      longitud = location.longitude.toString();
    });
  }
}
