class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final double rating;
  final List<String> genres;
  final String posterPath;
  final int runtime;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.rating,
    required this.genres,
    required this.posterPath,
    required this.runtime,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      rating: json['rating'].toDouble(),
      genres: List<String>.from(json['genres']),
      posterPath: json['poster_url'],
      runtime: json['runtime'],
    );
  }
}
