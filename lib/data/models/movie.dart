/// Movie model for API response
///
class Movie {
  final String? originalTitle;
  final String? posterPath;
  final DateTime? releaseDate;
  final double? voteAverage;

  Movie({
    this.originalTitle,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        voteAverage: json["vote_average"]?.toDouble(),
      );
}
