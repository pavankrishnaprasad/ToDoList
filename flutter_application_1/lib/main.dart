import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
import 'app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/auth': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(onThemeToggle: _toggleTheme),
      },
    );
  }
}