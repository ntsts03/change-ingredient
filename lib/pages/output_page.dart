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
              'AI食材代替検索',
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
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
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
                    // textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.answer,
                style: const TextStyle(fontSize: 20, height: 1.5),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('戻る'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
