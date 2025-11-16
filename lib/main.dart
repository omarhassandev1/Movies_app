import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app/app_routes.dart';
import 'package:movies_app/features/main_layer/profile/profile.dart';
import 'common/theme/app_theme.dart';

// DummyCubit placeholder
class DummyCubit extends Cubit<int> {
  DummyCubit() : super(0);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Object>(create: (_) => Object()), // placeholder repository
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DummyCubit>(create: (_) => DummyCubit()), // placeholder cubit
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
      routes: AppRoutes.appRoutes,
      home: const ProfileScreen(),
    );
  }
}

