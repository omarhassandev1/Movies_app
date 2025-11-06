import 'package:equatable/equatable.dart';
import '../../../../data/models/movie.dart';
abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}
class HomeInitial extends HomeState {
  const HomeInitial();
}
class HomeLoading extends HomeState {
  const HomeLoading();
}
class HomeLoaded extends HomeState {
  final List<Movie> featured;
  final List<Movie> action;
  const HomeLoaded(this.featured, this.action);

  @override
  List<Object> get props => [featured, action];
}

class HomeError extends HomeState {
  const HomeError();
}