import 'package:get/get.dart';

import '../models/movie_detail_model.dart';
import '../models/cast_model.dart';
import '../services/movie_service.dart';

class MovieDetailController extends GetxController {
  final int movieId; // ── NEW ── constructor se movieId lenge

  MovieDetailController({required this.movieId});

  final isLoading = false.obs;
  final errorMessage = RxnString();

  final Rxn<MovieDetailModel> movieDetail = Rxn<MovieDetailModel>();
  // ── NEW ── Rxn kyunke shuru mein movie detail hai hi nahi (null), jab tak API se na aaye

  final cast = <CastModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovieDetail();
  }

  Future<void> fetchMovieDetail() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      final results = await Future.wait([
        MovieService.getMovieDetail(movieId),
        MovieService.getMovieCast(movieId),
      ]);

      movieDetail.value = results[0] as MovieDetailModel;
      cast.value = results[1] as List<CastModel>;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}