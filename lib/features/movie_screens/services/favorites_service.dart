import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../models/movie_model.dart';

class FavoritesService {
  static final _box = GetStorage();
  static const String _key = 'favorites';
  static List<MovieModel> getFavorites() {
    final data = _box.read(_key);

    if (data == null) return [];

    final List decoded = jsonDecode(data);
    return decoded.map((json) => MovieModel.fromJson(json)).toList();
  }

  static void addFavorite(MovieModel movie) {
    final favorites = getFavorites();

    if (favorites.any((m) => m.id == movie.id)) return;

    favorites.add(movie);
    _saveFavorites(favorites);
  }

  static void removeFavorite(int movieId) {
    final favorites = getFavorites();
    favorites.removeWhere((m) => m.id == movieId); // ── NEW ── us ID wali movie hata do
    _saveFavorites(favorites);
  }

  static bool isFavorite(int movieId) {
    final favorites = getFavorites();
    return favorites.any((m) => m.id == movieId);
  }

  static void _saveFavorites(List<MovieModel> favorites) {
    final jsonList = favorites.map((m) => m.toJson()).toList();
    _box.write(_key, jsonEncode(jsonList)); // ── NEW ── List<Map> ko String mein encode karke save
  }
}