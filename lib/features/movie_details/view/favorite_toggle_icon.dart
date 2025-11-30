import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/films_response.dart';

import '../../main_layer/profile/profile_features/favorites/cubits/fav_cubit.dart';
import '../../main_layer/profile/profile_features/favorites/data/models/favorites_response.dart';

class FavoriteToggleIcon extends StatefulWidget {
  final Movies movie;

  const FavoriteToggleIcon({super.key, required this.movie});

  @override
  State<FavoriteToggleIcon> createState() => _FavoriteToggleIconState();
}

class _FavoriteToggleIconState extends State<FavoriteToggleIcon> {
  bool _isFavorite = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkInitialStatus();
  }

  Future<void> _checkInitialStatus() async {
    try {
      final cubit = context.read<FavCubit>();
      final isFav = await cubit.checkMovieFavStatus(widget.movie.id.toString());
      setState(() {
        _isFavorite = isFav;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onTogglePressed() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    try {
      await context.read<FavCubit>().toggleFavoriteStatus(widget.movie.toFavMovie());
    } catch (e) {
      setState(() {
        _isFavorite = !_isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        width: 30,
        height: 30,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return IconButton(
      icon: Icon(
        Icons.bookmark_outlined,
        color: _isFavorite ? Colors.amber : Colors.white,
        size: 30,
      ),
      onPressed: _onTogglePressed,
    );
  }
}

extension MovieToFavMovie on Movies {
  FavMovie toFavMovie() {
    return FavMovie(
      movieId: id.toString(),
      name: title,
      rating: rating,
      imageURL: mediumCoverImage,
      year: year.toString(),
    );
  }
}
