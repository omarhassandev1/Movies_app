import 'package:flutter/material.dart';

// === Imports from feature/profile ===
import 'package:movies_app/features/main_layer/profile/view/screens/profile.dart';
// import 'package:movies_app/features/main_layer/profile/view/screens/update_profile.dart';

// === Imports from dev branch (auth + onboarding) ===
import 'package:movies_app/features/auth/view/login/login_screen.dart';
import 'package:movies_app/features/auth/view/forget_password/new_password.dart';
import 'package:movies_app/features/auth/view/forget_password/otp.dart';
import 'package:movies_app/features/auth/view/forget_password/verify_email.dart';
import 'package:movies_app/features/auth/view/signup/signup_screen.dart';
import 'package:movies_app/features/onboarding/view/get_started_screen.dart';
import 'package:movies_app/features/onboarding/view/onboarding_screen.dart';

import '../features/main_layer/profile/view/screens/reset_password.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> appRoutes = {
    // === Profile routes ===
    ProfileTab.routeName: (context) => const ProfileTab(),
    ProfileResetPassword.routeName: (context) => const ProfileResetPassword(),

    // === Auth routes ===
    LoginScreen.routeName: (context) => const LoginScreen(),
    SignUpScreen.routeName: (context) => const SignUpScreen(),
    VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
    OTPScreen.routeName: (context) => const OTPScreen(),
    NewPassword.routeName: (context) => const NewPassword(),

    // === Onboarding routes ===
    OnboardingScreen.routeName: (context) => const OnboardingScreen(),
    GetStartedScreen.routeName: (context) => const GetStartedScreen(),
  };
}
