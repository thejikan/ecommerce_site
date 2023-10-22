import 'package:flutter/material.dart';

Color? SelectCategoryColor(int category) {
  switch (category) {
    case 1:
      return Colors.blueGrey[100];
    case 2:
      return Colors.purple[100];
    case 3:
      return Colors.deepPurpleAccent[100];
    case 4:
      return Colors.deepOrange[100];
    case 5:
      return Colors.orangeAccent[100];
    default:
      return Colors.indigo[100];
  }
}