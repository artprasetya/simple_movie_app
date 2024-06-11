import 'dart:async';

import 'package:flutter/widgets.dart';

/// Debouncer class for debouncing Search widget changes
///
/// @param delay - Duration of debounce in milliseconds
///
///
class Debouncer {
  final Duration? delay;
  Timer? _timer;

  Debouncer({
    this.delay = const Duration(milliseconds: 500),
  });

  void debounce(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay!, action);
  }
}
