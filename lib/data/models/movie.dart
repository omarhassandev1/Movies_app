import 'package:equatable/equatable.dart';
class Movie extends Equatable {
  final int id;
  final String title;
  final int year;
  final double rating;
  final String mediumCoverImage;
  final List<String> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.mediumCoverImage,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final List<dynamic> genreList = json['genres'] ?? [];
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Unknown',
      year: json['year'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      mediumCoverImage: json['medium_cover_image'] as String? ?? '',
      genres: genreList.cast<String>(),
    );
  }
  @override
  List<Object> get props => [id];
}
