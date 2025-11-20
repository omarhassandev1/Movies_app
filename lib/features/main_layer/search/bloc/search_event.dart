abstract class SearchEvent {}

class SearchMovies extends SearchEvent {
  final String? query;
  final Map<String, dynamic>? params;
  SearchMovies(this.query) : params = null;
  SearchMovies.withParams(this.params) : query = null;
}