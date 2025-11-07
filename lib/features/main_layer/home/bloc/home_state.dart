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
  final List<Movie> topRated;
  final List<Movie> latest;
  final List<Movie> mostDownloaded;
  final List<Movie> action;
  final List<Movie> comedy;
  final List<Movie> romance;
  final List<Movie> sciFi;
  final List<Movie> horror;
  final List<Movie> drama;
  final List<Movie> animation;

  const HomeLoaded({
    required this.topRated,
    required this.latest,
    required this.mostDownloaded,
    required this.action,
    required this.comedy,
    required this.romance,
    required this.sciFi,
    required this.horror,
    required this.drama,
    required this.animation,
  });

  @override
  List<Object> get props => [
    topRated, latest, mostDownloaded, action, comedy,
    romance, sciFi, horror, drama, animation
  ];
}

class HomeError extends HomeState {
  const HomeError();
}
