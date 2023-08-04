import 'dart:convert';

import 'package:animation/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../navigate.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _numberController = TextEditingController();

  void register(BuildContext context) async {
    try {
      Response response = await post(
        Uri.parse('http://10.0.2.2:8000/api/register'),
        body: {
          'name': _usernameController.text.toString(),
          'password': _passwordController.text.toString(),
          'mobile_no': _numberController.text.toString(),
        },
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());

        // AppNavigator().push(context, LoginScreen());
        var snackBar = SnackBar(
          content: Text(data['user']),
        );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (kDebugMode) {
          print(data);
        }
      } else if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        var snackBar = SnackBar(
          content: Text(data['message']),
        );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        if (kDebugMode) {
          print(data['message']);
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
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: theme.textTheme.displayLarge
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              color: Colors.black87,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  textfield(_usernameController, 'name'),
                  const SizedBox(
                    height: 20,
                  ),
                  textfield(_passwordController, 'password'),
                  const SizedBox(
                    height: 20,
                  ),
                  textfield(_numberController, 'number'),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black87)),
                        onPressed: () {
                          register(context);
                        },
                        child: Text(
                          'register',
                          style: theme.textTheme.titleLarge
                              ?.copyWith(color: Colors.white),
                        )),
                  ),
                  TextButton(
                      onPressed: () {
                        AppNavigator().push(context, LoginScreen());
                      },
                      child: Text('login'))
                ],
              ),
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
