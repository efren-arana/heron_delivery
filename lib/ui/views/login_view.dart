import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/constants/route_names.dart' as routes;
import 'package:heron_delivery/core/providers/login_view_model.dart';
import 'package:heron_delivery/ui/shared/ui_helpers.dart';
import 'package:heron_delivery/ui/widgets/busy_button.dart';
import 'package:provider/provider.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _visiblepwd = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              _crearFondo(context), 
              _loginForm(context)
              ],
          )),
    );
  }

  /// Metodo privado que disena el fonde de nuestro login
  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //Image de la cabecera
    final headerImage = SafeArea(
      child: Container(
        width: double.infinity,
        height: size.height * 0.2,
        padding: EdgeInsets.only(top: 80.0),
        child: Image.asset(
          'assets/img/heron.png',
          fit: BoxFit.fitWidth,
        ))
      );
    
    
    //clipper design de la curva
    final clipPath = ClipPath(
      clipper: _BackgroundClipper(),
      child: Container(
        width: size.width,
        height: size.width * 0.35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[getColorYellowRGBO, getColorYellowGradient],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );

    //Columna que tiene la iamgen de cabecera y la curba en la parte inferior
    return Column(
      children: [
        Align(alignment: Alignment.topCenter, child: headerImage),
        Expanded(child: Container()),
        Align(alignment: Alignment.bottomCenter, child: clipPath)
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size =
        MediaQuery.of(context).size; //obtengo el tamanio de la pantalla

    return Consumer<LoginViewModel>(
      builder: (context,model,child) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SafeArea(
              child: Container(
                height: size.height * 0.2,
              ),
            ),
            Container(
              width: size.width * 0.80,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              padding: EdgeInsets.symmetric(vertical: 25.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: 3.0)
                  ]),
              child: Form(
                autovalidate: true,
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Text('Iniciar sesion', style: TextStyle(fontSize: 20.0)),
                    verticalSpaceMedium,
                    _inputEmail(model),
                    verticalSpaceMedium,
                    _inputPwd(model),
                    verticalSpaceMedium,
                    _submitButton(model),
                    verticalSpaceSmall,
                  ],
                ),
              ),
            ),
            _faceboolButton(model),
            _registerLink(model),
            SizedBox(height: size.height * 0.3)
          ],
        ),
      ),
    );
  }

  Widget _inputEmail(LoginViewModel model) {
    //trabaja directamente con un formulario
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: TextFormField(
        onSaved: (value) => null,
        validator: model.validateEmail,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'ejemplo@correo.com',
          icon: FaIcon(Icons.email, color: getColorBlueRGBO),
          labelText: 'Email',
          helperText: 'example@example.com',
          suffixIcon: Icon(Icons.alternate_email),
        ),
      ),
    );
  }

  Widget _inputPwd(LoginViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: TextFormField(
        obscureText: !_visiblepwd,
        onSaved: (value) => null,
        validator: model.validatePwd,
        autofocus: false,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          icon: FaIcon(Icons.lock_outline, color: getColorBlueRGBO),
          labelText: 'Password',
          suffixIcon: GestureDetector(
              onTap: () => setState(() {
                    _visiblepwd = !_visiblepwd;
                    print(
                        '==========================_visiblepwd: $_visiblepwd');
                  }),
              child: Container(
                  child: Icon(
                      _visiblepwd ? Icons.visibility : Icons.visibility_off))),
        ),
      ),
    );
  }

  Widget _submitButton(LoginViewModel model) {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Ingresar'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 0.0,
        color: getColorBlueRGBO,
        onPressed: model.);
  }

  Widget _faceboolButton(LoginViewModel model) {
    return RaisedButton.icon(
      icon: FaIcon(FontAwesomeIcons.facebook),
        label: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Continuar con Facebook'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 0.0,
        color: facebookColor,
        onPressed: null);
  }

  Widget _registerLink(LoginViewModel model) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No tienes cuenta?\u0020'),
          GestureDetector(
            onTap: null,
            child: Text(
              'Registrate',
              style:
              TextStyle(color: getColorBlueRGBO, fontWeight: FontWeight.bold),
          )
    ),
        ],
      ),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controllPoint = Offset(size.height, 150);
    var endPoint = Offset(size.width, size.height / 4);
    var path = Path();

    path.moveTo(0, size.height - 100);
    //path.lineTo(size.height - 200, 0);

    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(0, size.width * 1000);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
