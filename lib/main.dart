import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/presentation/pages/number_trivia_page.dart';

import 'injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Number Trivia',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: MessageDisplay(message: "Still working..."),
    );
  }
}
