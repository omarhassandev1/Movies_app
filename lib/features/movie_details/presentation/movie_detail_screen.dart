import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'package:movies_app/features/movie_details/bloc/detail_bloc.dart';
import 'package:movies_app/features/movie_details/bloc/detail_event.dart';
import 'package:movies_app/features/movie_details/bloc/detail_state.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailBloc(RepositoryProvider.of<MovieRepository>(context))
        ..add(LoadDetail(movieId)),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              );
            }
            if (state is DetailLoaded) {
              final movie = state.movie;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          movie.mediumCoverImage,
                          height: 320,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 320,
                            color: Colors.grey[800],
                            child: const Icon(Icons.movie, size: 80, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${movie.year} • ${movie.rating} stars',
                      style: const TextStyle(color: Colors.yellow, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    if (movie.genres.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        children: movie.genres
                            .map((g) => Chip(
                          label: Text(g),
                          backgroundColor: Colors.grey[800],
                          labelStyle: const TextStyle(color: Colors.white, fontSize: 13),
                        ))
                            .toList(),
                      ),
                    if (movie.genres.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'No genres available',
                          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                      ),
                    const SizedBox(height: 24),
                    const Text(
                      'You Might Also Like',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.suggestions.length,
                        itemBuilder: (_, i) {
                          final suggestion = state.suggestions[i];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => MovieDetailScreen(movieId: suggestion.id),
                                ),
                              );
                            },
                            child: Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 12),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      suggestion.mediumCoverImage,
                                      height: 140,
                                      width: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        height: 140,
                                        color: Colors.grey[800],
                                        child: const Icon(Icons.movie, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    suggestion.title,
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: Text(
                'Failed to load movie details.',
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          },
        ),
      ),
    );
  }
}