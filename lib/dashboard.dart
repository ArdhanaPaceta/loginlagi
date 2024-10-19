import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  
import 'dart:io' show Platform; 

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    String username = args?['username'] ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome Message
            Text(
              'Welcome, $username!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),

            // Exit Button
            ElevatedButton(
              onPressed: () {
                _exitApp(context);
              },
              child: Text('Exit App'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _exitApp(BuildContext context) {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
      
        SystemNavigator.pop();
      } else {
       
        _showUnsupportedPlatformDialog(context);
      }
    } catch (e) {
      
      _showUnsupportedPlatformDialog(context);
    }
  }

  void _showUnsupportedPlatformDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Unsupported Operation"),
          content: Text("Closing the app is not supported on this platform."),
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
}
