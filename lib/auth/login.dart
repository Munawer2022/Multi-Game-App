import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _numberController = TextEditingController();

  void login() async {
    try {
      Response response = await post(
        Uri.parse('http://10.0.2.2:8000/api/login'),
        body: {
          'name': _usernameController.text.toString(),
          'password': _passwordController.text.toString(),
          'mobile_no': _numberController.text.toString(),
        },
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (kDebugMode) {
          print(data['token']);
        }
        if (kDebugMode) {
          print('login successfully');
        }
      } else {
        if (kDebugMode) {
          print('failed');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textfield(_usernameController, 'name'),
            const SizedBox(
              height: 20,
            ),
            textfield(_numberController, 'number'),
            const SizedBox(
              height: 20,
            ),
            textfield(_passwordController, 'password'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text('login')),
            ),
          ],
        ),
      ),
    );
  }
}

Widget textfield(controller, name) {
  return CupertinoTextField(
      padding: const EdgeInsets.all(15),
      controller: controller,
      placeholder: name);
}
