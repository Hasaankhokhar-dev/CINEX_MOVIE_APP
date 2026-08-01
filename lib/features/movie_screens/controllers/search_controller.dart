import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/movie_model.dart';
import '../services/movie_service.dart';

class MovieSearchController extends GetxController {

  final searchTextController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = RxnString();
  final searchResults = <MovieModel>[].obs;
  final hasSearched = false.obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    searchTextController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = searchTextController.text.trim();
      if (query.isNotEmpty) {
        searchMovies(query);
      } else {
        searchResults.clear();
        hasSearched.value = false;
      }
    });
  }

  Future<void> searchMovies(String query) async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      hasSearched.value = true;

      final movies = await MovieService.searchMovies(query);
      searchResults.value = movies;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    searchTextController.dispose();
    super.onClose();
  }
}