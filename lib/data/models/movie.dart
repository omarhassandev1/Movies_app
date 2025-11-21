import 'package:equatable/equatable.dart';
class Movie extends Equatable {
  final int id;
  final String title;
  final int year;
  final double rating;
  final String mediumCoverImage;
  final String? largeCoverImage;
  final List<String> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.mediumCoverImage,
    this.largeCoverImage,
    this.genres = const [],
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'Unknown',
      year: json['year'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      mediumCoverImage: json['medium_cover_image'] ?? '',
      largeCoverImage: json['large_cover_image'],
      genres: (json['genres'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  @override
  List<Object?> get props => [id];
}