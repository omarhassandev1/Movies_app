import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/films_response.dart';

class ApiManager {
  static Future<filmsResponse?> getMoviesList() async {
    try {
      Uri url = Uri.https("yts.lt", "/api/v2/list_movies.json", {
        "quality": "3D",
      });
      http.Response response = await http.get(url);

      if (response.statusCode == 200) { // Check if request is successful
        var json = jsonDecode(response.body);
        filmsResponse films = filmsResponse.fromJson(json);
        return films;
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("Exception: is $e");
      return null;
    }
  }
  static Future<filmsResponse> getSuggestions() async {
    Uri url = Uri.https("yts.lt", "/api/v2/movie_suggestions.json", {
      "movie_id": "10",
    });
    http.Response response=await http.get(url);

    var json = jsonDecode(response.body);
    filmsResponse films = filmsResponse.fromJson(json);
    return films;
  }

  static Future<Movies?> getMovieDetails(int movieId) async {
    try {
      Uri url = Uri.https("yts.lt", "/api/v2/movie_details.json", {
        "movie_id": movieId.toString(),
      });

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json['data'] != null && json['data']['movie'] != null) {
          Movies movie = Movies.fromJson(json['data']['movie']);
          return movie;
        } else {
          return null;
        }
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

}