import 'package:get/get.dart';

import '../models/movie_model.dart';
import '../services/movie_service.dart';

class HomeController  extends GetxController{
  final isLoading = false.obs;
  final errorMessage = RxnString();
  final popularMovies = <MovieModel>[].obs;
  final lastMonthMovies = <MovieModel>[].obs;
  final last6MonthMovies = <MovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPopularMovies();
  }

  Future<void> fetchAllMovies() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final results = await Future.wait([
        MovieService.getPopularMovies(),
        MovieService.getLastMonthMovies(),
        MovieService.getLast6MonthMovies(),
      ]);

      popularMovies.value = results[0];
      lastMonthMovies.value = results[1];
      final lastMonthIds = results[1].map((m) => m.id).toSet();
      last6MonthMovies.value = results[2]
          .where((m) => !lastMonthIds.contains(m.id))
          .toList();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPopularMovies() => fetchAllMovies();
}