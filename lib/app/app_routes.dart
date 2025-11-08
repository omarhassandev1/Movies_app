import 'package:flutter/material.dart';
import 'package:movies_app/features/auth/view/login/login_screen.dart';
import '../features/auth/view/forget_password/new_password.dart';
import '../features/auth/view/forget_password/otp.dart';
import '../features/auth/view/forget_password/verify_email.dart';
import '../features/auth/view/signup/signup_screen.dart';
import '../features/onboarding/view/get_started_screen.dart';
import '../features/onboarding/view/onboarding_screen.dart';

class AppRoutes {
  static final Map<String,WidgetBuilder> appRoutes = {
    LoginScreen.routeName : (context) => const LoginScreen(),
    SignUpScreen.routeName : (context) => const SignUpScreen(),
    OnboardingScreen.routeName : (context) => const OnboardingScreen(),
    GetStartedScreen.routeName : (context) => const GetStartedScreen(),
    VerifyEmailScreen.routeName : (context) => const VerifyEmailScreen(),
    OTPScreen.routeName : (context) => const OTPScreen(),
    NewPassword.routeName : (context) => const NewPassword(),

  };
}
