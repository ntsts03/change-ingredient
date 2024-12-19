import 'package:change_ingredient/change_ingredient.dart';
import 'package:change_ingredient/function_calling_setting.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'env/env.dart';


void main() {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: Env.geminiApiKey,
    tools: [
      Tool(functionDeclarations: answerController),
    ],
  );

  runApp(ChangeIngredient(model: model));
}
