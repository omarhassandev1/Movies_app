import 'package:equatable/equatable.dart';
import 'package:movies_app/data/models/movie.dart';
abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchLoaded extends SearchState {
  final List<Movie> movies;
  const SearchLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}
class SearchError extends SearchState {}