import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/services/form_service.dart';
import 'package:heron_delivery/core/viewmodels/login_view_model.dart';
import 'package:heron_delivery/locator.dart';
import 'package:heron_delivery/ui/shared/ui_helpers.dart';
import 'package:provider/provider.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart' as theme;



class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FormService _formKeyService = locator<FormService>();
  bool _visiblepwd = false;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              _crearFondo(context), 
              _loginForm(context)],
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
            child: Image.asset(
              'assets/img/heron.png',
              fit: BoxFit.fitWidth,
            )));

    //clipper design de la curva
    final clipPath = ClipPath(
      clipper: _BackgroundClipper(),
      child: Container(
        width: size.width,
        height: size.width * 0.35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              theme.getColorYellowRGBO,
              theme.getColorYellowGradient
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );

    //Columna que tiene la iamgen de cabecera y la curva en la parte inferior
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
      builder: (context, model, child) => 
      (model.busy) 
      ?  child
      : SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SafeArea(
              child: Container(
                height: size.height * 0.15,
              ),
            ),
            Container(
              height: size.height * 0.5,
              width: size.width * 0.80,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              padding: EdgeInsets.symmetric(vertical: 10.0),
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
              child: Center(
                child: Form(
                  key: _formKeyService.formKey,
                  onChanged: () => model.validateForm(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Iniciar sesion', style: theme.subHeaderStyle),
                      verticalSpaceMedium,
                      _inputEmail(model),
                      verticalSpaceMedium,
                      _inputPwd(model),
                      verticalSpaceMedium,
                      verticalSpaceMedium,
                      _submitButton(model),
                    ],
                  ),
                ),
              ),
            ),
            verticalSpaceSmall,
            _facebooklButton(model),
             verticalSpaceSmall,
            _registerLink(model),
          ],
        ),
      ),
      child: Center(
            child: CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation(
              theme.getColorBlueHex
             ),
            ),
          ),
    );
  }

  Widget _inputEmail(LoginViewModel model) {
    //trabaja directamente con un formulario
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: TextFormField(
        onSaved: (value) => _email = value,
        validator: model.validateEmail,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'example@correo.com',
          icon: FaIcon(Icons.email, color: theme.getColorBlueRGBO),
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
        onSaved: (value) => _password = value,
        validator: model.validatePwd,
        autofocus: false,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          icon: FaIcon(Icons.lock_outline, color: theme.getColorBlueRGBO),
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
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 0.0,
        color: (model.formValidated)
        ? theme.getColorBlueHex
        : Color.fromRGBO(99, 101, 105, 0.4),
        onPressed: () {
          if (model.formValidated) {
            //salva los valores de todos los campos del formulario
            _formKeyService.save();
            model.submitForm(email: _email, password: _password);
          }
        });
  }

  Widget _facebooklButton(LoginViewModel model) {
    return RaisedButton.icon(
        textColor: Colors.white,
        icon: FaIcon(FontAwesomeIcons.facebook,color: Colors.white,),
        label: Container(
          
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Center(child: Text('Continuar con Facebook')),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 0.0,
        color: theme.facebookColor,
        onPressed: ( )=> model.loginFacebook());
  }

  Widget _registerLink(LoginViewModel model) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No tienes cuenta?\u0020\u0020\u0020\u0020'),
          GestureDetector(
              onTap: ()=> model.navigateToSignPage(),
              child: Text(
                'Registrate',
                style: theme.textLink),
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
