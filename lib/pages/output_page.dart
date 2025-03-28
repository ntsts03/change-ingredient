import 'package:flutter/material.dart';

class OutputPage extends StatefulWidget {
  const OutputPage({
    super.key,
    required this.answer,
    required this.dish,
    required this.ingredient,
  });

  final String answer;
  final String dish;
  final String ingredient;

  @override
  State<OutputPage> createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  List<String> get answerList {
    return widget.answer.split('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              'Noフード → Goフード',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const SizedBox(width: 24),
                  Text(
                    '「${widget.dish}」の「${widget.ingredient}」の代替食材',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ボディ
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        color: const Color(0xFFFEEAD3), // 背景色を濃いめに
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xFFFFCCAA),
                            width: 2,
                          ),
                        ),
                        child: Container(
                          width: 300,
                          height: 100,
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              answerList.isNotEmpty ? answerList[0] : '',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Card(
                        color: const Color(0xFFFEEAD3), // 背景色を濃いめに

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xFFFFCCAA),
                            width: 2,
                          ),
                        ),
                        child: Container(
                          width: 300,
                          height: 100,
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              answerList.length > 1 ? answerList[1] : '',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Card(
                        color: const Color(0xFFFEEAD3), // 背景色を濃いめに

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xFFFFCCAA),
                            width: 2,
                          ),
                        ),
                        child: Container(
                          width: 300,
                          height: 100,
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              answerList.length > 2 ? answerList[2] : '',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Card(
                        color: const Color(0xFFFEEAD3), // 背景色を濃いめに

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xFFFFCCAA),
                            width: 2,
                          ),
                        ),
                        child: Container(
                          width: 300,
                          height: 100,
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              answerList.length > 3 ? answerList[3] : '',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Card(
                        color: const Color(0xFFFEEAD3), // 背景色を濃いめに

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xFFFFCCAA),
                            width: 2,
                          ),
                        ),
                        child: Container(
                          width: 300,
                          height: 100,
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              answerList.length > 4 ? answerList[4] : '',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFEE8B4E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.reply),
                      SizedBox(width: 8),
                      Text(
                        '検索画面へ戻る',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
