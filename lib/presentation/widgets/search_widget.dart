import 'package:flutter/material.dart';

class MovieSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const MovieSearchWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          isDense: true,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(12.0),
          hintText: 'Search movie by title',
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          suffixIcon: controller.text == ''
              ? null
              : IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.clear();
                    focusNode.unfocus();
                    onChanged(controller.text);
                  },
                ),
        ),
      ),
    );
  }
}
