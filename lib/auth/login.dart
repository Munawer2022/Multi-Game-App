import 'dart:convert';
import 'package:animation/auth/register.dart';
import 'package:animation/navigate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text;
    String password = _passwordController.text;
    String number = _numberController.text;

    // Replace 'YOUR_LOGIN_API_URL' with your actual login API URL.
    var apiUrl = 'http://127.0.0.1:8000/api/login';
    var requestBody = {
      'name': username,
      'password': password,
      'mobile_no': number
    };

    try {
      Response response = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody));

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print('Login Successful: $responseData');
        // Redirect to the next screen or do whatever you want here.
      } else {
        var errorData = json.decode(response.body);
        print('Login Failed: $errorData');
        // Show an error message to the user or handle the error accordingly.
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'name'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              // obscureText: true,
            ),
            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AppNavigator().push(context, RegisterScreen());
              },
              child: Text('register'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
