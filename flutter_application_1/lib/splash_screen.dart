import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/auth');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 20),
              Text(
                'ToDo List App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Organize your tasks efficiently',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}