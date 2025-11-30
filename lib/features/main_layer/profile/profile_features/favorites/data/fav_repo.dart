import 'package:shared_preferences/shared_preferences.dart';
import 'fav_api_services.dart';
import 'models/favorites_response.dart';

class FavRepo {
  final FavApiServices apiServices;

  FavRepo({required this.apiServices});

  Future<List<FavMovie>> getFavMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    if (authToken == null) {
      throw Exception('Authentication token not found. User needs to sign in.');
    }
    final response = await apiServices.getFavMovies(token: authToken);
    final favMoviesResponse = FavoritesResponse.fromJson(response.data);
    if (response.statusCode == 200 && favMoviesResponse.data != null) {
      if (favMoviesResponse.message == 'favourites fetched successfully') {
        return favMoviesResponse.data!;
      } else {
        throw Exception('Could not get the user\'s favorite movies');
      }
    } else {
      throw Exception('Favorites are not found');
    }
  }

  Future<void> addToFavorites(FavMovie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) throw Exception('Authentication token not found.');

    final response = await apiServices.addMovieToFav(
      token,
      movieId: movie.movieId!,
      name: movie.name!,
      rating: movie.rating!,
      imageURL: movie.imageURL!,
      year: movie.year!,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add movie to favorites');
    }
  }

  Future<bool> isMovieFav(String movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    if (authToken == null) {
      throw Exception('Authentication token not found. User needs to sign in.');
    }
    final response = await apiServices.isMovieFav(
      token: authToken,
      movieId: movieId,
    );
    if (response.statusCode == 200 &&
        response.data['message'] == "Favourite status fetched successfully") {
      if (response.data["data"] is bool) {
        bool isFav = response.data["data"];
        return isFav;
      } else {
        throw Exception('API response structure incorrect for movie status.');
      }
    } else {
      throw Exception(
        'Could not get the movie\'s state. Status: ${response.statusCode}',
      );
    }
  }

  Future<void> removeFavMovie(String movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    if (authToken == null) {
      throw Exception('Authentication token not found. User needs to sign in.');
    }
    final response = await apiServices.removeFavMovie(
      token: authToken,
      movieId: movieId,
    );
    if (response.statusCode == 200 &&
        response.data['message'] == "Removed from favourite successfully") {
      return;
    } else {
      throw Exception(
        'Could not get the movie\'s state. Status: ${response.statusCode}',
      );
    }
  }
}
