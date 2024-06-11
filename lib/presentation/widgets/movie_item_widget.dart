import 'package:flutter/material.dart';
import 'package:simple_movie_app/data/models/movie.dart';

class MovieItemWidget extends StatelessWidget {
  final Movie movie;

  const MovieItemWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Poster
              ///
              Expanded(
                flex: 1,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),

              /// Details
              ///
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Rating
                      ///
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            movie.voteAverage?.toStringAsFixed(1) ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      /// Movie name
                      ///
                      Text(
                        movie.originalTitle ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      /// Movie year
                      Text(
                        movie.releaseDate?.year.toString() ?? '',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
