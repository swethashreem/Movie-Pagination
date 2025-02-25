import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_assignment/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieProvider =
    StateNotifierProvider<MovieNotifier, AsyncValue<List<MovieModel>>>((ref) {
  return MovieNotifier();
});

class MovieNotifier extends StateNotifier<AsyncValue<List<MovieModel>>> {
  MovieNotifier() : super(const AsyncValue.loading()) {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final String response =
          await rootBundle.loadString('assets/movie_details.json');
      final Map<String, dynamic> data = json.decode(response);
      final movies = [MovieModel.fromJson(data)];
      state = AsyncValue.data(movies);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
