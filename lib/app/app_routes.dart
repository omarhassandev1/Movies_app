import 'package:flutter/material.dart';

import '../features/main_layer/browse/view/film_details.dart';

class AppRoutes {
  static final Map<String,WidgetBuilder> appRoutes = {

      FilmDetails.routeName: (context) => FilmDetails(),


    // ExampleScreen.routeName : (context) => ExampleScreen(),

  };
}
