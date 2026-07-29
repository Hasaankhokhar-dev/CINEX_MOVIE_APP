import 'package:flutter_dotenv/flutter_dotenv.dart';

class TmdbConstants {
  static final String apiKey = dotenv.env['TMDB_API_KEY'] ?? '';

  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String popularMovies = '$baseUrl/movie/popular';

  static const String discoverMovies = '$baseUrl/discover/movie';

  static String movieDetail(int id) => '$baseUrl/movie/$id';

  static String movieCredits(int id) => '$baseUrl/movie/$id/credits';


}