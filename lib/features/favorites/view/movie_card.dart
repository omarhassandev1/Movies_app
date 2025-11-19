import 'package:flutter/material.dart';
import 'package:movies_app/features/favorites/view/rating_widget.dart';

import '../data/models/favorites_response.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.favMovie});
  final FavMovie favMovie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(
              favMovie.imageURL ??
                  'https://sparkclothingclub.com/cdn/shop/files/IMG-5349.png?v=1721237683',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [RatingWidget(rating: favMovie.rating ?? 0)],
          ),
        ),
      ),
    );
  }
}
