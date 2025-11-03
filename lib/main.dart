import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/app/app_routes.dart';

import 'package:movies_app/common/theme/app_theme.dart';
import 'package:movies_app/features/auth/data/auth_api_service.dart';
import 'package:movies_app/features/auth/view/login/login_screen.dart';
import 'package:movies_app/features/onboarding/view/get_started_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/data/auth_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dio setup
  final routeApi = Dio(
    BaseOptions(
      baseUrl: "https://route-movie-apis.vercel.app/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // final moviesApi = Dio(
  //   BaseOptions(
  //     baseUrl: "https://yts.mx/api/",
  //     connectTimeout: const Duration(seconds: 10),
  //     receiveTimeout: const Duration(seconds: 10),
  //   ),
  // );

  // service & repo
  final authService = AuthApiService(routeApi);
  final authRepo = AuthRepo(authService);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  // run app with provider above MaterialApp
  runApp(
    // repository provider اختياري لكن مفيد لو هتستخدم repo في أماكن تانية
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(authRepo)),
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
      initialRoute:
          seenOnboarding ? LoginScreen.routeName : GetStartedScreen.routeName,
      routes: AppRoutes.appRoutes,
    );
  }
}
