import 'package:equatable/equatable.dart';
import 'package:movies_app/data/models/movie.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object?> get props => [];
}

class DetailInitial extends DetailState {
  const DetailInitial();
}

class DetailLoading extends DetailState {
  const DetailLoading();
}

class DetailLoaded extends DetailState {
  final Movie movie;
  final List<Movie> suggestions;

  const DetailLoaded(this.movie, this.suggestions);

  @override
  List<Object?> get props => [movie, suggestions];
}

class DetailError extends DetailState {
  final String message;
  const DetailError([this.message = 'Something went wrong']);

  @override
  List<Object?> get props => [message];
}