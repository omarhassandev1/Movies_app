import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/app/app_routes.dart';
import 'package:movies_app/common/consts/api_consts.dart';

// ======== Profile imports (from feature/profile) ========
import 'package:movies_app/features/main_layer/profile/view/screens/profile.dart';

// ======== Shared / Theme ========
import 'package:movies_app/common/theme/app_theme.dart';

// ======== Auth + Onboarding imports (from dev) ========
// import 'package:movies_app/features/auth/data/auth_api_service.dart';
// import 'package:movies_app/features/auth/view/login/login_screen.dart';
// import 'package:movies_app/features/onboarding/view/get_started_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/data/auth_api_service.dart';
import 'features/auth/data/auth_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // === Dio setup ===
  final routeApi = Dio(
    BaseOptions(
      baseUrl: RouteApiConsts.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // === Auth service & repo (from dev branch) ===
  final authService = AuthApiService(routeApi);
  final authRepo = AuthRepo(authService);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  // === Run the app with providers ===
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit(authRepo)),
      ],
      child: MyApp(seenOnboarding: seenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.seenOnboarding});
  final bool seenOnboarding;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,

      // === Keep AppRoutes from both branches ===
      routes: AppRoutes.appRoutes,

      // === dev branch logic for onboarding ===
      initialRoute: ProfileScreen.routeName
          // seenOnboarding ? LoginScreen.routeName : GetStartedScreen.routeName,
    );
  }
}
