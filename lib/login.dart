import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  String _registeredUsername = '';
  String _registeredPassword = '';

  // Error message
  String? _usernameError;
  String? _passwordError;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null) {
      _registeredUsername = args['username'] ?? '';
      _registeredPassword = args['password'] ?? '';
    }
  }

  void _login() {
    setState(() {
      //error messages
      _usernameError = null;
      _passwordError = null;
    });

    // Validasi username and password
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameError = "Please enter a username.";
      });
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = "Please enter a password.";
      });
    } else if (_usernameController.text == _registeredUsername &&
        _passwordController.text == _registeredPassword) {
      Navigator.pushReplacementNamed(context, '/dashboard',
          arguments: {'username': _registeredUsername});
    } else {
      _showErrorDialog("Invalid username or password");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Failed"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // App Title
                Text(
                  'HELLO GUYS',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 20),

                // Login Title
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 20),

                // Username TextField
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    errorText: _usernameError,
                  ),
                ),
                SizedBox(height: 20),

                // Password TextField
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    errorText: _passwordError,
                  ),
                ),
                SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0), backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),

                SizedBox(height: 20),

                // Sign Up Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
