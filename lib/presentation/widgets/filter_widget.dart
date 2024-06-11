import 'package:flutter/material.dart';
import 'package:simple_movie_app/data/models/category.dart';

class MovieFilterWidget extends StatelessWidget {
  final int? moviesCount;
  final List<Category> categories;
  final Function(int, bool) onFilterChange;

  const MovieFilterWidget({
    Key? key,
    this.moviesCount = 0,
    required this.categories,
    required this.onFilterChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Filter by Rating'),
              Text('Result: $moviesCount'),
            ],
          ),
          const SizedBox(height: 8),

          // horizontal List of categories use Chips
          SizedBox(
            height: 50,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ChoiceChip(
                  label: Text(categories[index].name ?? ''),
                  labelStyle: TextStyle(
                    color: categories[index].activeState ?? false
                        ? Colors.black
                        : Colors.white,
                  ),
                  selected: categories[index].activeState ?? false,
                  selectedColor: Colors.white,
                  onSelected: (value) {
                    onFilterChange(index, value);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 8),
            ),
          ),
        ],
      ),
    );
  }
}
