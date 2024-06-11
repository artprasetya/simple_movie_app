import 'package:flutter/material.dart';
import 'package:simple_movie_app/data/models/movie.dart';
import 'package:simple_movie_app/presentation/widgets/movie_item_widget.dart';

class MovieListWidget extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<Movie> movies;

  const MovieListWidget({
    Key? key,
    this.isLoading = false,
    this.errorMessage,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Show error message if any error occurs
    ///
    if (errorMessage != null) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                size: 100,
              ),
              const SizedBox(height: 8),
              Text(errorMessage.toString()),
            ],
          ),
        ),
      );
    }

    /// Show progress indicator if loading is in progress
    ///
    if (isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    /// Show empty message if no movies are available in list
    ///
    if (movies.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.movie,
                size: 100,
              ),
              SizedBox(height: 8),
              Text('No movies found'),
            ],
          ),
        ),
      );
    }

    /// Show list of movies if movies are available in list
    ///
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieItemWidget(movie: movies[index]);
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
      ),
    );
  }
}
