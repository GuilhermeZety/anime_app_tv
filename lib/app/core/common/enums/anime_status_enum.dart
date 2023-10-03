import 'package:flutter/material.dart';

enum AnimeStatus {
  inProgress,
  completed;

  String get name {
    switch (this) {
      case AnimeStatus.inProgress:
        return 'Em andamento';
      case AnimeStatus.completed:
        return 'Completo';
      default:
        return 'Em andamento';
    }
  }

  Color get color {
    switch (this) {
      case AnimeStatus.inProgress:
        return Colors.orange;
      case AnimeStatus.completed:
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
