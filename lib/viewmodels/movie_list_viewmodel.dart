import 'package:flutter/material.dart';
import 'package:simple_movie_app/data/models/category.dart';
import 'package:simple_movie_app/data/models/movie.dart';
import 'package:simple_movie_app/services/api_services.dart';
import 'package:simple_movie_app/utils/debouncer.dart';

class MovieListViewModel extends ChangeNotifier {
  ///
  /// Services and Utils
  ///
  final ApiServices _apiServices = ApiServices();
  final Debouncer _debouncer = Debouncer();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  ///
  /// Variables
  ///
  bool _isLoading = false;
  String? _errorMessage;
  String _searchText = '';

  final List<Category> _categories = [
    Category(name: 'All', rateValue: 2, activeState: true),
    Category(name: 'Bad', rateValue: 4, activeState: false),
    Category(name: 'Good', rateValue: 6, activeState: false),
    Category(name: 'Great', rateValue: 8, activeState: false),
    Category(name: 'Recommended', rateValue: 9, activeState: false),
  ];

  late Category? _selectedCategory = categories[0];

  late List<Movie> _movies = [];
  late List<Movie> _filteredMovies = movies;

  ///
  /// Getters and Setters
  ///
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? get errorMessage => _errorMessage;
  set errorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  TextEditingController get controller => _controller;

  FocusNode get focusNode => _focusNode;

  List<Category> get categories => _categories;
  set categories(List<Category> value) {
    _categories.addAll(value);
    notifyListeners();
  }

  String get searchText => _searchText;
  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  Category? get selectedCategory => _selectedCategory;
  set selectedCategory(Category? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  List<Movie> get movies => _movies;
  set movies(List<Movie> value) {
    _movies = value;
    notifyListeners();
  }

  List<Movie> get filteredMovies => _filteredMovies;
  set filteredMovies(List<Movie> value) {
    _filteredMovies = value;
    notifyListeners();
  }

  int get moviesCount => filteredMovies.length;

  ///
  /// Public Methods
  ///
  Future<void> init() async {
    isLoading = true;

    await _getMovieList();
    _getFilteredMovies();

    isLoading = false;
  }

  void onFilterChange(int index, bool selected) {
    /// Change the state of the selected category
    /// and filter the movie list
    ///
    categories.asMap().forEach((i, category) {
      category.activeState = i == index ? selected : false;
    });

    selectedCategory = categories[index];
    _getFilteredMovies();
  }

  void onSearchChanged(String value) {
    _debouncer.debounce(() {
      searchText = value;
      _getFilteredMovies();
    });
  }

  ///
  /// Private Methods
  ///

  /// Get movie list from API
  ///
  Future<void> _getMovieList() async {
    try {
      movies = await _apiServices.fetchMovieList();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
  }

  /// Get filtered movie list
  /// based on search text and selected category
  ///
  void _getFilteredMovies() {
    isLoading = true;

    if (searchText.isNotEmpty || selectedCategory != null) {
      filteredMovies = movies.where((movie) {
        /// check if movie title matches the search text
        ///
        final titleMatch = movie.originalTitle
            .toString()
            .toLowerCase()
            .contains(searchText.toLowerCase());

        /// check if movie rating matches the selected category
        ///
        final ratingMatch = movie.voteAverage != null &&
            selectedCategory != null &&
            movie.voteAverage! >= selectedCategory!.rateValue!.toDouble();
        return titleMatch && ratingMatch;
      }).toList();
    } else {
      /// if no search text or category is selected, show all movies
      filteredMovies = movies;
    }

    isLoading = false;
  }
}
