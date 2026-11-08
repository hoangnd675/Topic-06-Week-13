import 'package:flutter/material.dart';
import '../features/registration/views/registration_page.dart';

class Topic06App extends StatelessWidget {
  const Topic06App({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF635BFF);
    return MaterialApp(
      title: 'Topic 06 · Form Validation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
          surface: const Color(0xFFF7F8FC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E7EF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E7EF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: seed, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE05260)),
          ),
        ),
      ),
      home: const RegistrationPage(),
    );
  }
}
