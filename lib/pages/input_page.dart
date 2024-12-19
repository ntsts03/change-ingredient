import 'package:change_ingredient/function_calling_setting.dart';
import 'package:change_ingredient/gemini_prompt.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'output_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key, required this.model});

  final GenerativeModel model;

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController dishController = TextEditingController();
  final TextEditingController ingredientController = TextEditingController();

  bool isLoading = false;
  String? answer = '';

  @override
  void dispose() {
    dishController.dispose();
    ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '食材の代替案を見つけましょう！',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                '苦手な食材やアレルギーのある食材を入力すると、'
                'その代わりになる食材を提案します。\n'
                '例えば、牛乳を使いたくない場合には豆乳を提案します。',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: dishController,
                decoration: const InputDecoration(
                  labelText: '料理名',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ingredientController,
                decoration: const InputDecoration(
                  labelText: '替えたい食材',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : () async {
                  await getAnswer();
                  if (answer != null && answer!.isNotEmpty) {
                    // if (!mounted) return;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OutputPage(answer: answer ?? ''),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('代わりの食材を検索'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getAnswer() async {
    setState(() {
      isLoading = true;
    });

    final contents = [
      Content.text(geminiPrompt),
      Content.text(dishController.text),
      Content.text(ingredientController.text),
    ];

    GenerateContentResponse? response;
    try {
      response = await widget.model.generateContent(contents);
    } on Exception catch (e) {
      answer = 'エラーが発生しました1。 $e';
      setState(() {
        isLoading = false;
      });

      return;
    }

    final functionCalls = response.functionCalls.toList();

    try {
      if (functionCalls.isNotEmpty) {
        final functionCall = functionCalls.first;

        answer = switch (functionCall.name) {
          'setFood' => setFood(functionCall.args)?.toString(),
          _ => throw UnimplementedError(
              'Function not implemented: ${functionCall.name}',
            )
        };
      }
    } on Exception catch (e) {
      answer = 'エラーが発生しました2。 $e';
      setState(() {
        isLoading = false;
      });

      return;
    }

    if (answer == null || answer!.isEmpty) {
      answer = '回答できませんでした';

      setState(() {
        isLoading = false;
      });

      return;
    }

    setState(() {
      isLoading = false;
    });
  }
}
