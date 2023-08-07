import 'dart:convert';

import 'package:animation/auth/login/login.dart';
import 'package:animation/dashboard.dart';
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
        AppNavigator().push(context, const Dahboard());
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
              height: size.height * 0.4,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/register_bac.jpg',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: theme.textTheme.displayLarge?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
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
                  textfield(_usernameController, 'Name'),
                  const SizedBox(
                    height: 20,
                  ),
                  textfield(_passwordController, 'Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  textfield(_numberController, 'Phone No'),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blue.shade300)),
                        onPressed: () {
                          register(context);
                        },
                        child: Text(
                          'Register',
                          style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account ? ',
                          style: theme.textTheme.titleMedium),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade300)),
                          onPressed: () {
                            AppNavigator().push(context, LoginScreen());
                          },
                          child:
                              //  const CircularProgressIndicator()
                              Text(
                            'login',
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
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
