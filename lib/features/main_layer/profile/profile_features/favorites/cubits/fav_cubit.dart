import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/fav_repo.dart';
import '../data/models/favorites_response.dart';
import 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  final FavRepo favRepo;
  FavCubit({required this.favRepo}) : super(FavoriteInitial());

  Future<void> getAllFavorites() async {
    emit(FavoriteLoading());
    try {
      final favMovies = await favRepo.getFavMovies();
      emit(FavoriteGetSuccess(favMovies: favMovies));
    } catch (e) {
      emit(FavoriteError(errorMessage: e.toString()));
    }
  }

  Future<void> addToFavorites(FavMovie movie) async {
    emit(FavoriteLoading());
    try {
      await favRepo.addToFavorites(movie);
      if (state is FavoriteGetSuccess) {
        final currentFavs = List<FavMovie>.from((state as FavoriteGetSuccess).favMovies);
        currentFavs.add(movie);
        emit(FavoriteGetSuccess(favMovies: currentFavs));
      } else {
        final favMovies = await favRepo.getFavMovies();
        emit(FavoriteGetSuccess(favMovies: favMovies));
      }
    } catch (e) {
      emit(FavoriteError(errorMessage: e.toString()));
    }
  }

  Future<void> removeFavMovie(String movieId) async {
    emit(FavoriteLoading());
    try {
      await favRepo.removeFavMovie(movieId);
      if (state is FavoriteGetSuccess) {
        final currentFavs = List<FavMovie>.from((state as FavoriteGetSuccess).favMovies);
        currentFavs.removeWhere((element) => element.movieId==movieId,);
        emit(FavoriteGetSuccess(favMovies: currentFavs));
      } else {
        final favMovies = await favRepo.getFavMovies();
        emit(FavoriteGetSuccess(favMovies: favMovies));
      }
    } catch (e) {
      emit(FavoriteError(errorMessage: e.toString()));
    }
  }

  Future<bool> checkMovieFavStatus(String movieId) async {
    try {
      final isFav = await favRepo.isMovieFav(movieId);
      return isFav;
    } catch (e) {
      throw Exception('Failed to check movie favorite status: ${e.toString()}');
    }
  }

  Future<void> toggleFavoriteStatus(FavMovie movie) async {
    try {
      final isCurrentlyFav = await checkMovieFavStatus(movie.movieId!);

      if (isCurrentlyFav) {
        await removeFavMovie(movie.movieId!);
      } else {
        await addToFavorites(movie);
      }

    } catch (e) {
      emit(FavoriteError(errorMessage: e.toString()));
    }
  }
}
