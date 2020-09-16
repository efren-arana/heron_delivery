import 'package:flutter/material.dart';
import 'package:heron_delivery/core/constants/route_names.dart' as routes;
import 'package:heron_delivery/core/providers/signup_view_model.dart';
import 'package:heron_delivery/ui/shared/ui_helpers.dart';
import 'package:heron_delivery/ui/widgets/busy_button.dart';
import 'package:heron_delivery/ui/widgets/expansion_list.dart';
import 'package:heron_delivery/ui/widgets/input_field.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 38,
                  ),
                ),
                verticalSpaceLarge,
                InputField(
                  placeholder: 'Full Name',
                  controller: fullNameController,
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Email',
                  controller: emailController,
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Password',
                  password: true,
                  controller: passwordController,
                  additionalNote:
                      'Password has to be a minimum of 6 characters.',
                ),
                verticalSpaceSmall,
                ExpansionList<String>(
                    items: ['Admin', 'User'],
                    title: model.selectedRole,
                    onItemSelected: model.setSelectedRole),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BusyButton(
                      title: 'Sign Up',
                      busy: model.busy,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(routes.RouteTabView);
                        //model.signUp(
                        //    email: emailController.text,
                        //    password: passwordController.text,
                        //    fullName: fullNameController.text);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
