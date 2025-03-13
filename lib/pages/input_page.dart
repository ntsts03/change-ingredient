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
      appBar: AppBar(
        backgroundColor: const Color(0xFFEE8B4E),
        title: const Row(
          children: [
            Icon(
              Icons.restaurant,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              'AI食材代替検索',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32.0, 8.0, 16.0, 16.0),
              child: Text(
                '苦手な食材やアレルギーのある食材を入力すると、\n'
                'その代わりになる食材を提案します。 例えば、牛乳\n'
                'を使いたくない場合には豆乳を提案します。',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Align(
        alignment: const Alignment(0, -0.4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '料理名（任意）',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: dishController,
                    decoration: InputDecoration(
                      hintText: '例: カレー、肉じゃが、パスタなど',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '苦手な食材・アレルギー食材',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: ingredientController,
                    decoration: InputDecoration(
                      hintText: '例: 牛乳、卵、小麦粉など',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            await getAnswer();
                            if (answer != null && answer!.isNotEmpty) {
                              if (!mounted) return;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OutputPage(
                                    answer: answer ?? '',
                                    dish: dishController.text,
                                    ingredient: ingredientController.text,
                                  ),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEE8B4E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 8),
                        Text(
                          '検索',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
