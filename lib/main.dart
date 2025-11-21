import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app/app_routes.dart';
import 'package:movies_app/features/favorites/cubits/fav_cubit.dart';
import 'package:movies_app/features/main_layer/profile/cubit/profile_cubit.dart';

// ======== Feature import (from home-feature) ========
import 'package:movies_app/features/main_layer/home/screens/home_screen.dart';

// ======== Profile imports (from feature/profile) ========
import 'package:movies_app/features/main_layer/profile/view/screens/profile.dart';

// ======== Shared / Theme ========
import 'package:movies_app/common/theme/app_theme.dart';

// ======== Auth + Onboarding imports (from dev) ========
import 'package:movies_app/features/auth/view/login/login_screen.dart';
import 'package:movies_app/features/onboarding/view/get_started_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/service_locator/service_locator.dart';
import 'features/auth/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // === Run the app with providers ===
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(ServiceLocator.authRepo),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(profileRepo: ServiceLocator.profileRepo),
        ),
        BlocProvider<FavCubit>(
          create: (_) => FavCubit(favRepo: ServiceLocator.favRepo),
        ),
      ],
      child: MyApp(seenOnboarding: seenOnboarding, isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.seenOnboarding,
    required this.isLoggedIn,
  });
  final bool seenOnboarding;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: AppTheme.themeData,

      routes: AppRoutes.appRoutes,

      initialRoute:
          isLoggedIn
              ? HomeScreen.routeName
              : seenOnboarding
              ? LoginScreen.routeName
              : GetStartedScreen.routeName,
    );
  }
}
