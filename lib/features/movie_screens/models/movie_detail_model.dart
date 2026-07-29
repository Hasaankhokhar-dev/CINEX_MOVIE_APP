class MovieDetailModel {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String overview;
  final double voteAverage;
  final String releaseDate;
  final int runtime;
  final List<String> genres;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
 });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(json['genres']?.map((genre) => genre['name']) ?? []),

    );
  }

  String get posterUrl => posterPath != null && posterPath!.isNotEmpty
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : '';

  String get backdropUrl => backdropPath != null && backdropPath!.isNotEmpty
      ? 'https://image.tmdb.org/t/p/original$backdropPath'
      : '';

  String get year => releaseDate.isNotEmpty && releaseDate.length >= 4
      ? releaseDate.substring(0, 4)
      : '';

  String get runtimeFormatted {
    if (runtime == 0) return '';

    final hours = runtime ~/ 60;

    final minutes = runtime % 60;

    return '${hours}hr ${minutes}min';
  }

  String get genresText => genres.join('/');

}