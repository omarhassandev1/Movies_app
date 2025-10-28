import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app/app_routes.dart';

// 🧩 Features Imports
// Auth Feature Example
// import 'features/auth/cubit/auth_cubit.dart';
// import 'features/auth/data/auth_repo.dart';
// import 'features/auth/data/auth_service.dart';

// 🎨 App Theme
import 'common/theme/app_theme.dart';

// 🧭 Screens / Routing
// import 'features/auth/views/sign_in_screen.dart';
// import 'features/splash/view/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize repositories / services for each feature
  // final authService = AuthService();
  // final authRepo = AuthRepo(authService);

  runApp(
    //  MultiRepositoryProvider contains all repositories
    MultiRepositoryProvider(
      providers: [
        // RepositoryProvider<AuthRepo>.value(value: authRepo),
        // RepositoryProvider<MoviesRepo>.value(value: moviesRepo),
        // RepositoryProvider<FavoritesRepo>.value(value: favoritesRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider<AuthCubit>(
          //   create: (context) => AuthCubit(authRepo),
          // ),
          // BlocProvider<MoviesCubit>(
          //   create: (context) => MoviesCubit(moviesRepo),
          // ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,

      // to add a route add it in the AppRoutes class
      routes: AppRoutes.appRoutes,

      home: const Scaffold(
        body: Center(
          child: Text(
            '🎬 Movies App Base Project\n(Ready for feature integration)',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
