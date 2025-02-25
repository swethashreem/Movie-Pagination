import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  MovieDetailScreen({required this.movieId});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Map<String, dynamic>? movieDetail;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchMovieDetail();
  }

  Future<void> fetchMovieDetail() async {
    try {
      final String response =
          await rootBundle.loadString('assets/movie_details.json');
      final Map<String, dynamic> data = json.decode(response);

      setState(() {
        movieDetail = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Detail')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text('Error: $error'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      movieDetail!['poster_url'] != null
                          ? Image.network(movieDetail!['poster_url'])
                          : Container(height: 200, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        movieDetail!['title'] ?? 'No Title',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                          'Release Date: ${movieDetail!['release_date'] ?? 'N/A'}'),
                      SizedBox(height: 8),
                      Text('Genres: ${movieDetail!['genres'].join(", ")}'),
                      SizedBox(height: 8),
                      Text('Runtime: ${movieDetail!['runtime']} minutes'),
                      SizedBox(height: 16),
                      Text(movieDetail!['overview'] ?? 'No Description'),
                    ],
                  ),
                ),
    );
  }
}
