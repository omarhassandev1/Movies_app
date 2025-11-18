import 'package:flutter/material.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/common/widgets/custom_textfield.dart';

import '../../../../gen/assets.gen.dart';
import 'otp.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  static const String routeName = 'verifyEmail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget password'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          spacing: 24,
          children: [
            Assets.onboardingAuth.forgetPassword.forgerPassword.svg(),
            CustomTextField(prefixIcon: Assets.onboardingAuth.icons.email.svg(),hintText: 'Email',),
            CustomMainButton(onPressed: (){
              Navigator.of(context).pushNamed(OTPScreen.routeName);
            }, text: 'Verify Email')
          ],
        ),
      ),
    );
  }
}
