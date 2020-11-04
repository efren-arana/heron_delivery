import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/viewmodels/login_view_model.dart';
import 'package:heron_delivery/ui/shared/background_auth.dart';
import 'package:heron_delivery/ui/shared/ui_helpers.dart';
import 'package:provider/provider.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart' as theme;

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _visiblepwd = false;
  String _email;
  String _password;
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size; //obtengo el tamanio de la pantalla
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(_formKey),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [BackGroundAuth(), _loginForm(context)],
          )),
    );
  }


  Widget _loginForm(BuildContext context) {

    return Consumer<LoginViewModel>(
      builder: (context, model, child) => (model.busy)
          ? child
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      height: _size.height * 0.15,
                    ),
                  ),
                  Container(
                    height: _size.height * 0.5,
                    width: _size.width * 0.80,
                    margin: EdgeInsets.only(
                      top: _size.height * 0.03,
                      left: _size.width * 0.01,
                      right: _size.width * 0.01,
                      bottom: _size.height * 0.02
                      ),
                    padding: EdgeInsets.only(
                      top: _size.height * 0.01,
                      left: _size.width * 0.01,
                      right: _size.width * 0.01,
                      bottom: _size.height * 0.01
                    ),
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
                    child: Container(
                      child: Form(
                        key: _formKey,
                        onChanged: () => model.validateForm(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Log in', style: theme.subHeaderStyle),
                            verticalSpaceMedium,
                            _inputEmail(model),
                            verticalSpaceMedium,
                            _inputPwd(model),
                            SizedBox(
                              height: _size.height * 0.02,
                            ),
                            _submitButton(model),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: _size.height * 0.01),
                  _facebooklButton(model),
                  SizedBox(height: _size.height * 0.01),
                  _registerLink(model),
                  SafeArea(
                    child: Container(
                      height: _size.height * 0.05,
                    ),
                  ),
                ],
              ),
            ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation(theme.getColorBlueHex),
        ),
      ),
    );
  }

  Widget _inputEmail(LoginViewModel model) {
    //trabaja directamente con un formulario
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _size.width * 0.01,
        ),
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
      padding: EdgeInsets.symmetric(
        horizontal: _size.width * 0.01,
        ),
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
          padding: EdgeInsets.symmetric(
            horizontal: _size.width * 0.15, 
            vertical: _size.height * 0.02
            ),
          child: Text(
            'Log in',
            style: TextStyle(color: Colors.white),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 1.0,
        color: (model.formValidated)
            ? theme.getColorBlueHex
            : Color.fromRGBO(99, 101, 105, 0.4),
        onPressed: () {
          if (model.formValidated) {
            //salva los valores de todos los campos del formulario
            //Se ejecuta este metodo para poder almacenar los valores y se pueden enviar al submit
            _formKey.currentState.save();
            model.submitLoginForm(email: _email, password: _password);
          }
        });
  }

  Widget _facebooklButton(LoginViewModel model) {
    return RaisedButton.icon(
        textColor: Colors.white,
        icon: FaIcon(
          FontAwesomeIcons.facebook,
          color: Colors.white,
        ),
        label: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _size.width * 0.1, 
            vertical: _size.height * 0.02
            ),
          child: Center(child: Text('Continuar con Facebook')),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        color: theme.facebookColor,
        onPressed: () => model.loginFacebook());
  }

  Widget _registerLink(LoginViewModel model) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No tienes cuenta?\u0020\u0020\u0020\u0020'),
          GestureDetector(
            onTap: () => model.navigateToSignPage(),
            child: Text('Registrate', style: theme.textLink),
          ),
        ],
      ),
    );
  }
}
