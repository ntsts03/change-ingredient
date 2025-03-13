import 'package:google_generative_ai/google_generative_ai.dart';

final foodSchema = Schema(
  SchemaType.object,
  properties: {
    'dishName': Schema(
      SchemaType.string,
      description: '料理の名前',
    ),
    'ingredients': Schema(
      SchemaType.array,
      items: Schema(SchemaType.string),
      description: '代替食材の提案（必ず5つ）',
    ),
  },
  requiredProperties: ['dishName', 'ingredients'],
);

final answerController = [
  FunctionDeclaration(
    'setFood',
    '料理名と代替食材を設定してください',
    foodSchema,
  ),
];

class FoodResponse {
  final String dishName;
  final List<String> ingredients;

  FoodResponse({
    required this.dishName,
    required this.ingredients,
  });

  @override
  String toString() {
    final numberMarks = ['①', '②', '③', '④', '⑤'];
    final List<String> numberedList = [];
    for (var i = 0; i < ingredients.length; i++) {
      numberedList.add('${numberMarks[i]} ${ingredients[i]}');
    }
    return numberedList.join('\n');
  }
}

FoodResponse? setFood(Map<String, Object?> arguments) {
  final dishName = arguments['dishName'] as String?;
  final ingredients =
      (arguments['ingredients'] as List<dynamic>?)?.cast<String>();

  if (dishName == null || ingredients == null || ingredients.length != 5) {
    return null;
  }
  return FoodResponse(
    dishName: dishName,
    ingredients: ingredients,
  );
}
