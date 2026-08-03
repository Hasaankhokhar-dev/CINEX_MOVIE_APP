import 'package:get/get.dart';

import '../models/movie_detail_model.dart';
import '../models/cast_model.dart';
import '../models/movie_model.dart';
import '../models/video_model.dart';
import '../services/favorites_service.dart';
import '../services/movie_service.dart';

class MovieDetailController extends GetxController {
  final int movieId;

  MovieDetailController({required this.movieId});

  final isLoading = false.obs;
  final errorMessage = RxnString();

  final Rxn<MovieDetailModel> movieDetail = Rxn<MovieDetailModel>();
  final cast = <CastModel>[].obs;
  final trailerKey = RxnString();
  final isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovieDetail();
    isFavorite.value = FavoritesService.isFavorite(movieId);

  }

  Future<void> fetchMovieDetail() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      final results = await Future.wait([
        MovieService.getMovieDetail(movieId),
        MovieService.getMovieCast(movieId),
        MovieService.getMovieVideos(movieId),
      ]);

      movieDetail.value = results[0] as MovieDetailModel;
      cast.value = results[1] as List<CastModel>;
      final videos = results[2] as List<VideoModel>;
      trailerKey.value = _findBestTrailer(videos);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


  void toggleFavorite() {
    final movie = movieDetail.value;
    if (movie == null) return;

    if (isFavorite.value) {
      FavoritesService.removeFavorite(movie.id);
    } else {
      final movieToSave = MovieModel(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        backdropPath: movie.backdropPath,
        overview: movie.overview,
        voteAverage: movie.voteAverage,
        releaseDate: movie.releaseDate,
      );
      FavoritesService.addFavorite(movieToSave);
    }
    isFavorite.value = !isFavorite.value;
  }





  String? _findBestTrailer(List<VideoModel> videos) {
    final trailers = videos
        .where((v) => v.type == 'Trailer' && v.official)
        .toList();
    if (trailers.isEmpty) return null;
    trailers.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
    return trailers.last.key;
  }
}