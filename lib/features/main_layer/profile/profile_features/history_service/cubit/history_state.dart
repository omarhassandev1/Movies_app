import 'package:movies_app/data/models/movie.dart';

abstract class HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Movie> movies;
  HistoryLoaded(this.movies);
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}
