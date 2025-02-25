import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchUsers(int page) async {
    try {
      final response = await _dio
          .get('https://reqres.in/api/users', queryParameters: {'page': page});
      return response.data['data'];
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<Map<String, dynamic>> addUser(String name, String job) async {
    try {
      final response = await _dio.post('https://reqres.in/api/users',
          data: {"name": name, "job": job});
      return response.data;
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  Future<List<dynamic>> fetchTrendingMovies(int page) async {
    const apiKey = 'YOUR_API_KEY';
    try {
      final response = await _dio.get(
        'https://dummyapi.io/movies/{movieId}',
        queryParameters: {'language': 'en-US', 'page': page, 'api_key': apiKey},
      );
      return response.data['results'];
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetail(int movieId) async {
    const apiKey = 'YOUR_API_KEY';
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/$movieId',
        queryParameters: {'api_key': apiKey},
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}
