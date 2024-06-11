import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie_app/presentation/widgets/filter_widget.dart';
import 'package:simple_movie_app/presentation/widgets/list_widget.dart';
import 'package:simple_movie_app/presentation/widgets/search_widget.dart';
import 'package:simple_movie_app/viewmodels/movie_list_viewmodel.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movies'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => MovieListViewModel()..init(),
        child: Consumer<MovieListViewModel>(
          builder: (context, viewmodel, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search bar
                MovieSearchWidget(
                  controller: viewmodel.controller,
                  focusNode: viewmodel.focusNode,
                  onChanged: viewmodel.onSearchChanged,
                ),

                // Filters
                MovieFilterWidget(
                  moviesCount: viewmodel.moviesCount,
                  categories: viewmodel.categories,
                  onFilterChange: viewmodel.onFilterChange,
                ),

                // Movie list
                MovieListWidget(
                  isLoading: viewmodel.isLoading,
                  errorMessage: viewmodel.errorMessage,
                  movies: viewmodel.filteredMovies,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
