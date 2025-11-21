import 'package:dio/dio.dart';
import 'package:movies_app/data/models/movie.dart';
class MovieRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://yts.lt/api/v2',
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));

  Future<List<Movie>> listMovies({Map<String, dynamic>? params}) async {
    final response = await _dio.get('/list_movies.json', queryParameters: params ?? {});

    if (response.data['status'] == 'ok') {
      final List<dynamic> movies = response.data['data']['movies'] ?? [];
      return movies.map((json) => Movie.fromJson(json)).toList();
    }
    throw Exception('API Error: ${response.data['status_message']}');
  }

  Future<Movie> getMovieDetail(int id) async {
    final response = await _dio.get('/movie_details.json', queryParameters: {'movie_id': id});
    if (response.data['status'] == 'ok') {
      return Movie.fromJson(response.data['data']['movie']);
    }
    throw Exception('Failed to load movie detail');
  }

  Future<List<Movie>> getMovieSuggestions(int id) async {
    final response = await _dio.get('/movie_suggestions.json', queryParameters: {'movie_id': id});
    if (response.data['status'] == 'ok') {
      final List<dynamic> movies = response.data['data']['movies'] ?? [];
      return movies.map((e) => Movie.fromJson(e)).toList();
    }
    throw Exception('Failed to load suggestions');
  }
}
