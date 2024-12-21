import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/pages/format_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            FormatPage(),
          ],
        )
      ),
    );
  }
}
