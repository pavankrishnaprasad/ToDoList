import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isLogin ? Icons.login : Icons.person_add,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 16),
                    Text(
                      _isLogin ? 'Welcome Back' : 'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headlineLarge?.color,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _isLogin ? 'Sign in to continue' : 'Sign up to get started',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _authenticate,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(_isLogin ? 'Login' : 'Sign Up'),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin ? 'Create Account' : 'Already have an account?',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _authenticate() async {
    final prefs = await SharedPreferences.getInstance();
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (_isLogin) {
      // Login logic
      final storedUser = prefs.getString('user');
      if (storedUser != null) {
        final user = jsonDecode(storedUser);
        if (user['username'] == username && user['password'] == password) {
          // Success
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        } else {
          // Failed
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Invalid credentials'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No user found. Please sign up first.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } else {
      // Sign up
      final user = {'username': username, 'password': password};
      await prefs.setString('user', jsonEncode(user));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account created successfully! Please login.'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _isLogin = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}