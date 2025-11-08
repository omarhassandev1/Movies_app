import 'package:flutter/material.dart';
import 'package:movies_app/features/auth/view/login/login_screen.dart';

import '../../../../common/widgets/custom_main_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../../../gen/assets.gen.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});
  static const String routeName = 'newPassword';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget password'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 24,
            children: [
              Assets.onboardingAuth.forgetPassword.newPassword.svg(height: 400),
              CustomTextField(hintText: 'new password',),
              CustomTextField(hintText: 'confirm password',),
              CustomMainButton(onPressed: (){
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }, text: 'Change password')
            ],
          ),
        ),
      ),
    );
  }
}
