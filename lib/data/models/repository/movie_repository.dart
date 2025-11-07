import 'package:dio/dio.dart';
import 'package:movies_app/data/models/movie.dart';
class MovieRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://yts.mx/api/v2'));
  Future<List<Movie>> listMovies({Map<String, dynamic>? params}) async {
    final response = await _dio.get('/list_movies.json', queryParameters: params);
    if (response.data['status'] == 'ok') {
      final List<dynamic> movies = response.data['data']['movies'] ?? [];
      return movies.map((json) => Movie.fromJson(json)).toList();
    }
    throw Exception('Failed to load movies');
  }
  Future<Movie> getMovieDetail(int id) async {
    final response = await _dio.get('/movie_details.json', queryParameters: {'movie_id': id});
    if (response.data['status'] == 'ok') {
      return Movie.fromJson(response.data['data']['movie']);
    }
    throw Exception('Failed to load movie detail');
  }
  Future<List<Movie>> getMovieSuggestions(int id) async {
    final resp = await _dio.get('/movie_suggestions.json', queryParameters: {'movie_id': id});
    if (resp.data['status'] == 'ok') {
      final List<dynamic> list = resp.data['data']['movies'] ?? [];
      return list.map((e) => Movie.fromJson(e)).toList();
    }
    throw Exception('Failed to load suggestions');
  }
}