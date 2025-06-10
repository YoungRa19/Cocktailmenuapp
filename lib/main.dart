import 'package:flutter/material.dart';
import 'package:coktailmenuapp/dashboard/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Cocktail',
      theme: ThemeData(

        primaryColor: Color(0xFF191919),
        hintColor: Color(0xFF777777),
        scaffoldBackgroundColor: Color(0xFFE6E6E6),

        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Estilos de iconos
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      home: const Index(),
    );
  }
}