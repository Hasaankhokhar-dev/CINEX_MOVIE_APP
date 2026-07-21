import 'dart:convert';
import 'package:cinex_movie_app/features/movie_screens/models/movie_model.dart';
import 'package:cinex_movie_app/features/movie_screens/tmdb_constants/tmdb_constants.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${TmdbConstants.popularMovies}?api_key=${TmdbConstants.apiKey}',
        ),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final error = data['status_message'] ?? 'Something went wrong';
        throw _handleError(error);
      }
      final List results = data['results'];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<MovieModel>> getLastMonthMovies() async {
    final now = DateTime.now();
    final oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
    final dateFrom = _formatDate(oneMonthAgo);
    final dateTo = _formatDate(now);
    return _fetchByDateRange(dateFrom: dateFrom, dateTo: dateTo);
  }
  static Future<List<MovieModel>> getLast6MonthMovies() async {
    final now = DateTime.now();
    final sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);
    final dateFrom = _formatDate(sixMonthsAgo);
    final dateTo = _formatDate(now);
    return _fetchByDateRange(dateFrom: dateFrom, dateTo: dateTo);
  }

  static Future<List<MovieModel>> _fetchByDateRange({
    required String dateFrom,
    required String dateTo,
  }) async {
    try {
      final uri = Uri.parse(
        '${TmdbConstants.discoverMovies}'
            '?api_key=${TmdbConstants.apiKey}'
            '&primary_release_date.gte=$dateFrom'   // gte = greater than or equal
            '&primary_release_date.lte=$dateTo'     // lte = less than or equal
            '&sort_by=popularity.desc'              // popular pehle aaye
            '&vote_count.gte=50',                   // kam se kam 50 votes ho (garbage filter)
      );

      final response = await http.get(uri);
      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final error = data['status_message'] ?? 'Something went wrong';
        throw _handleError(error);
      }

      final List results = data['results'];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      rethrow;
    }
  }

  static String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0'); // 7 → "07"
    final day = date.day.toString().padLeft(2, '0');     // 5 → "05"
    return '${date.year}-$month-$day';
  }

  static String _handleError(String errorCode) {
    switch (errorCode) {
      case 'Invalid API key: You must be granted a valid key.':
        return 'Invalid API key';
      default:
        return errorCode.isNotEmpty ? errorCode : 'Something went wrong';
    }
  }
}
