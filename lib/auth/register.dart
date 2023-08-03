import 'dart:convert';
import 'package:animation/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../navigate.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text;
    String password = _passwordController.text;
    String number = _numberController.text;
    String password_confirmation = _passwordConfirmationController.text;

    // Replace 'YOUR_LOGIN_API_URL' with your actual login API URL.
    var apiUrl = 'http://192.168.100.39:8000/api/register';
    var requestBody = {
      'name': username,
      'password': password,
      'mobile_no': number,
      'password_confirmation': password_confirmation
    };

    try {
      print('run');
      Response response = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody));
      print(json.decode(response.body));

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
        title: Text('register Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoTextField(
              controller: _usernameController,
              placeholder: 'name',
              // decoration: BoxDecoration(labelText: 'name'),
            ),
            SizedBox(height: 20),
            CupertinoTextField(
              controller: _passwordController,
              placeholder: 'Password',
              // decoration: InputDecoration(labelText: 'Password'),
              // obscureText: true,
            ),
            SizedBox(height: 20),
            CupertinoTextField(
              controller: _passwordConfirmationController,
              placeholder: 'password_confirmation',
              // decoration: InputDecoration(labelText: 'password_confirmation'),
              // obscureText: true,
            ),
            SizedBox(height: 20),
            CupertinoTextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              placeholder: 'number',
              // decoration: InputDecoration(labelText: 'number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AppNavigator().push(context, LoginScreen());
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('register'),
                  ),
          ],
        ),
      ),
    );
  }
}
