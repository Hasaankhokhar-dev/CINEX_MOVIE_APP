import 'package:get/get.dart';

import '../models/movie_model.dart';
import '../services/favorites_service.dart';

class FavoritesController extends GetxController {
  final favorites = <MovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    favorites.value = FavoritesService.getFavorites();
  }

  void toggleFavorite(MovieModel movie) {
    if (FavoritesService.isFavorite(movie.id)) {
      FavoritesService.removeFavorite(movie.id);
    } else {
      FavoritesService.addFavorite(movie);
    }
    loadFavorites();
  }

  bool isFavorite(int movieId) {
    return FavoritesService.isFavorite(movieId);
  }
}