import 'package:flutter/material.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/common/widgets/custom_textfield.dart';
import 'package:movies_app/features/auth/view/forget_password/new_password.dart';

import '../../../../gen/assets.gen.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  static const String routeName = 'verifyOTP';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 24,
          children: [
            Assets.onboardingAuth.forgetPassword.otp.svg(height: 300),
            CustomTextField(hintText: 'OTP',),
            CustomMainButton(onPressed: (){
              Navigator.of(context).pushNamed(NewPassword.routeName);
            }, text: 'Verify OTP')
          ],
        ),
      ),
    );
  }
}
