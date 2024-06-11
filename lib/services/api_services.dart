import 'dart:convert';

import 'package:simple_movie_app/data/models/movie.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  /// Service to get movie list from API based on API key
  ///
  Future<List<Movie>> fetchMovieList() async {
    const apiKey = 'b031ecd04177e1c9aae4efcb44b3f301';
    final url = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson["results"] == null
          ? []
          : List<Movie>.from(
              responseJson["results"]?.map(
                (x) => Movie.fromJson(x),
              ),
            );
    } else {
      throw Exception('Failed to fetch movie data');
    }
  }
}
