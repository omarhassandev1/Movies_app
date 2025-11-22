import 'package:dio/dio.dart';

import '../../../../../../common/consts/api_consts.dart';

class FavApiServices {
  final Dio dio;

  FavApiServices({required this.dio});

  Future<Response> getFavMovies({required String token}) async {
    return dio.get(
      RouteApiConsts.getAllFavoritesMovies,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
