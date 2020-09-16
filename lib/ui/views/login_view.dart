import 'package:flutter/material.dart';
import 'package:heron_delivery/core/constants/route_names.dart' as routes;
import 'package:heron_delivery/core/providers/login_view_model.dart';
import 'package:heron_delivery/ui/shared/ui_helpers.dart';
import 'package:heron_delivery/ui/widgets/busy_button.dart';
import 'package:heron_delivery/ui/widgets/input_field.dart';
import 'package:heron_delivery/ui/widgets/text_link.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
        body: Consumer<LoginViewModel>(
          builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      child: Text('TITLE LOGIN'),
                    ),
                    InputField(
                      placeholder: 'Email',
                      controller: emailController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Password',
                      password: true,
                      controller: passwordController,
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BusyButton(
                          title: 'Login',
                          busy: model.busy,
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(routes.RouteTabView);
                            /*
                            model
                                .login(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                                .then((value) {
                              if (value is bool) {
                                if (!value) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'General login failure. Please try again later')));
                                }
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('${value.toString()}')));
                              }
                            });
                            */
                          },
                        )
                      ],
                    ),
                    verticalSpaceMedium,
                    TextLink(
                      'Create an Account if you\'re new.',
                      onPressed: () {
                        //model.navigateToSignPage();
                        Navigator.of(context).pushNamed(routes.RouteSignUpView);
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
