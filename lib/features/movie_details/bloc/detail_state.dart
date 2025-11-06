import 'package:equatable/equatable.dart';
import '../../../data/models/movie.dart';

abstract class DetailState extends Equatable {
  const DetailState();
  @override
  List<Object?> get props => [];
}
class DetailInitial extends DetailState {}
class DetailLoading extends DetailState {}
class DetailLoaded extends DetailState {
  final Movie movie;
  final List<Movie> suggestions;
  const DetailLoaded(this.movie, this.suggestions);
  @override
  List<Object?> get props => [movie, suggestions];
}
class DetailError extends DetailState {}