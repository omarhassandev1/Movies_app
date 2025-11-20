import 'package:movies_app/features/favorites/data/fav_api_services.dart';
import 'package:movies_app/features/favorites/data/models/favorites_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
