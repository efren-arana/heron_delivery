import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:heron_delivery/core/viewmodels/make_order_view_model.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart' as theme;

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
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size; //obtengo el tamanio de la pantalla
    return ChangeNotifierProvider(
        create: (context) => MakeOrderViewModel(),
        child: Scaffold(
          appBar: AppBar(),
          body: Consumer<MakeOrderViewModel>(
            builder: (context, model, child) => Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _textFormFieldPhoneNumber(model),
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
                    Text("Longitud: " + '$longitud'),
                    _makeOrderButton(model)
                  ],
                ),
              ),
            ),
          )
        ));
  }

  Widget _textFormFieldPhoneNumber(MakeOrderViewModel model) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.phone,
        enableInteractiveSelection: false,
        initialValue: model.phoneNumber,
        readOnly: true,
        onTap: () => model.navigateToAuthPhoneView(),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.grey[200])),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.grey[300])),
            filled: true,
            fillColor: Colors.grey[100],
            hintText: "Mobile Number"),
      ),
    );
  }

  Widget _makeOrderButton(MakeOrderViewModel model) {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: _size.width * 0.15, vertical: _size.height * 0.02),
          child: Text(
            'Hacer el pedido',
            style: TextStyle(color: Colors.white),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 1.0,
        color: (model.phoneNumberValidated)
            ? theme.getColorBlueHex
            : Color.fromRGBO(99, 101, 105, 0.4),
        onPressed: () {
          if (model.phoneNumberValidated) {
            //salva los valores de todos los campos del formulario
            //Se ejecuta este metodo para poder almacenar los valores y se pueden enviar al submit
            //_formKey.currentState.save();
            model.makeOrder();
          }
        });
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
