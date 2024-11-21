import 'package:flutter/material.dart';
import 'output_page.dart';

class ChangeIngredients extends StatelessWidget {
  const ChangeIngredients({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change Ingredients',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('チェンジ食材'),
        // ),
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
                const TextField(
                  decoration: InputDecoration(
                    labelText: '料理名',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: '替えたい食材',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const OutputPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text('代わりの食材を検索'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
