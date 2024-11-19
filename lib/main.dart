import 'package:flutter/material.dart';
import 'screens/validation_screen.dart';
import 'screens/success_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => ValidationScreen(),
        '/success': (context) => SuccessScreen(),
      },
    );
  }
}
