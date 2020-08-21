import 'package:flutter/material.dart';
import 'package:heron_delivery/src/cached/prefs_user.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSecundario;
  int _genero;
  String _nombre = '';
  TextEditingController _controller;
  PrefsUser prefs = new PrefsUser();

  @override
  void initState() {
    super.initState();
    //_cargarPrefs();
    prefs.ultimaPagina = SettingsPage.routeName;
    _colorSecundario = prefs.colorSecundario;
    _genero = prefs.genero;
    _nombre = prefs.nombre;
    _controller = new TextEditingController(text: _nombre);
  }

  /*
  _cargarPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _genero = (prefs.getInt('genero') ?? 1);
    setState(() {});
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
          title: Text('Ajustes'),
        ),
     //   drawer: MenuWidget(),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            SwitchListTile(
              value: _colorSecundario,
              onChanged: (value) {
                setState(() {
                  _colorSecundario = value;
                  prefs.colorSecundario = value;
                });
              },
              title: Text('Color Secundario'),
            ),
            RadioListTile(
              value: 1,
              title: Text('Masculino'),
              groupValue: _genero,
              onChanged: _setSelectedRadio,
            ),
            RadioListTile(
                value: 2,
                title: Text('Femenino'),
                groupValue: _genero,
                onChanged: _setSelectedRadio),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    labelText: 'Nombre', helperText: 'Nombre de la persona'),
                onChanged: (value) {
                  prefs.nombre = value;
                },
              ),
            )
          ],
        ));
  }

  _setSelectedRadio(int value) async {
    prefs.genero = value;
    _genero = value;
    setState(() {});
  }
}
