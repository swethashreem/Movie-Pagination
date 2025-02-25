import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/movie_provider.dart';
import 'movie_detail_screen.dart';

class MovieListScreen extends ConsumerStatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends ConsumerState<MovieListScreen> {
  @override
  Widget build(BuildContext context) {
    final movieState = ref.watch(movieProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Trending Movies')),
      body: movieState.when(
        data: (movies) => ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return ListTile(
              leading: movie.posterPath.isNotEmpty
                  ? Image.network(movie.posterPath)
                  : Container(width: 50, height: 50, color: Colors.grey),
              title: Text(movie.title),
              subtitle: Text(movie.releaseDate),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailScreen(movieId: movie.id)),
                );
              },
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
