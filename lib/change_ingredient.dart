import 'package:change_ingredient/pages/input_page.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChangeIngredient extends StatelessWidget {
  const ChangeIngredient({super.key, required this.model});

  final GenerativeModel model;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InputPage(
        model: model,
      ),
    );
  }
}
