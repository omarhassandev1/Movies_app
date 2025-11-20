import 'package:movies_app/features/favorites/data/models/favorites_response.dart';

abstract class FavState {}

class FavoriteInitial extends FavState {}

class FavoriteLoading extends FavState {}


class FavoriteGetSuccess extends FavState {
  final List<FavMovie> favMovies;

  FavoriteGetSuccess({required this.favMovies});
}

class FavoriteError extends FavState {
  final String errorMessage;

  FavoriteError({required this.errorMessage});
}