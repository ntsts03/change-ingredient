import 'package:flutter/material.dart';

class OutputPage extends StatelessWidget {
  const OutputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('検索結果'),
      ),
      body: const Center(
        child: Text('ここに検索結果が表示されます'),
      ),
    );
  }
}