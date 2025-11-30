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

  Future<Response> addMovieToFav(
    String token, {
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    return dio.post(
      '/favorites/add',
      data: {
        "movieId": movieId,
        "name": name,
        "rating": rating,
        "imageURL": imageURL,
        "year": year,
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<Response> isMovieFav({
    required String token,
    required String movieId,
  }) async {
    return dio.get(
      RouteApiConsts.isMovieFav + movieId,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<Response> removeFavMovie({
    required String token,
    required String movieId,
  }) async {
    return dio.delete(
      RouteApiConsts.removeFavMovie + movieId,
      data: {"movieId": movieId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
