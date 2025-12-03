import 'package:flutter/material.dart';
import 'package:stayin_ubud/core/theme/app_theme.dart';
import 'package:stayin_ubud/features/home/home_screen.dart';

void main() {
  runApp(const StayinUbudApp());
}

class StayinUbudApp extends StatelessWidget {
  const StayinUbudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StayinUBUD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
