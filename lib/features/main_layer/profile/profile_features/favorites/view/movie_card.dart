import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/features/main_layer/profile/profile_features/favorites/view/rating_widget.dart';
import '../../../../../movie_details/view/film_details.dart';
import '../data/models/favorites_response.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.favMovie});
  final FavMovie favMovie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int id = int.parse(favMovie.movieId ?? '0');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilmDetails(movieId: id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl:
                    favMovie.imageURL ??
                    'https://sparkclothingclub.com/cdn/shop/files/IMG-5349.png?v=1721237683',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [RatingWidget(rating: favMovie.rating ?? 0)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
