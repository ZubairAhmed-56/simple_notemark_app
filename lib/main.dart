import 'package:flutter/material.dart';
import 'package:simple_notemark_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple NoteMark App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const SplashScreen(), // Launch with splash screen
    );
  }
}
