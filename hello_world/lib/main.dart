import 'package:flutter/material.dart';

import 'gradient_container.dart';

void main() {
  runApp(const MaterialApp(
    // GradientContainer use const thus in front of MaterialApp also shall add const
    home: Scaffold(
      body: GradientContainer(
        Color.fromARGB(255, 191, 31, 212),
        Color.fromARGB(255, 19, 3, 126),
      ),
    ),
  ));
}
