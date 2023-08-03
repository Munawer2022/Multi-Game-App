import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';


import '../provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('login');
    final loginController = Provider.of<LoginProvider>(context);

    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // showAlert(),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(doctor),
                    SizedBox(
                      height: mediaQuery.height * 0.2,
                    ),
                    Text("Sign In", style: theme.textTheme.headline2),
                    SizedBox(
                      height: mediaQuery.height * 0.050,
                    ),
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
                    Button(
                        loading: loginController.loading,
                        title: 'Continue',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            loginController.loginPostApiResponse(context, {
                              'name': _usernameController.text,
                              'password': passwordController.text
                            });
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showAlert() {
    final loginController = Provider.of<LoginProvider>(context);
    if (loginController.errorShow != null) {
      return Container(
        color: Colors.red.shade400,
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.error_outline,
              ),
            ),
            Expanded(
              child: Text(
                loginController.errorShow.toString(),
                // style: TextStyle(color: Colors.black87),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    loginController.errorShow = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return const SizedBox(
      height: 0,
    );
  }
}
