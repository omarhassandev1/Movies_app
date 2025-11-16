import 'package:flutter/material.dart';
import 'package:movies_app/features/main_layer/profile/screens/history_screen.dart';
import 'package:movies_app/features/main_layer/profile/screens/profile.dart';
import 'package:movies_app/features/main_layer/profile/screens/ubdate_profile.dart';



class AppRoutes {
  static final Map<String, WidgetBuilder> appRoutes = {
    ProfileScreen.routeName: (context) => const ProfileScreen(),
    UpdateProfileScreen.routeName: (context) => const UpdateProfileScreen(),
    HistoryScreen.routeName: (context) => const HistoryScreen(),
  };
}

