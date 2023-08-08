import 'dart:convert';

import 'package:animation/auth/login/login.dart';
import 'package:animation/auth/login/provider.dart';

import 'package:animation/dashboard.dart';
import 'package:animation/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../navigate.dart';
import '../register/register.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _numberController = TextEditingController();

//   void register(BuildContext context) async {
//     try {
//       Response response = await post(
//         Uri.parse('http://10.0.2.2:8000/api/login'),
//         body: {
//           'name': _usernameController.text.toString(),
//           'password': _passwordController.text.toString(),
//           'mobile_no': _numberController.text.toString(),
//         },
//         headers: {'Accept': 'application/json'},
//       );
//       loadingBotton(true);

//       if (response.statusCode == 200) {
//         loadingBotton(true);
//         // AppNavigator().push(context, const Dahboard());
//         var data = jsonDecode(response.body.toString());

//         // AppNavigator().push(context, LoginScreen());
//         var snackBar = SnackBar(
//           content: Text(data['user']),
//         );

//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         if (kDebugMode) {
//           print(data);
//         }
//       } else if (response.statusCode == 401) {
//         loadingBotton(false);
//         var data = jsonDecode(response.body.toString());
//         var snackBar = SnackBar(
//           content: Text(data['message']),
//         );

// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);

//         if (kDebugMode) {
//           print(data['message']);
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//     }
//   }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginProvider>(context);
    // print(loginController.errorShow['message'].toString());

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
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
                            'Login',
                            style: theme.textTheme.displayLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      // TypeTextFieldComponent(
                      //     textInputAction: TextInputAction.next,
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Enter Name';
                      //       } else {
                      //         return null;
                      //       }
                      //     },
                      //     controller: _usernameController,
                      //     keyboardType: TextInputType.name,
                      //     hintText: 'Enter Name'),
                      textfield(
                        _usernameController,
                        'Name',
                        (value) {
                          if (value!.isEmpty) {
                            return 'Enter Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textfield(
                        _passwordController,
                        'Password',
                        (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textfield(
                        _numberController,
                        'Phone No',
                        (value) {
                          if (value!.isEmpty) {
                            return 'Enter Phone No';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Button(
                          loading: loginController.loading,
                          title: 'Login',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              loginController.loginPostApiResponse(context, {
                                'name': _usernameController.text.toString(),
                                'password': _passwordController.text.toString(),
                                'mobile_no': _numberController.text.toString(),
                              });
                            }
                          }
                          // loading: loading,
                          // title: 'Login',
                          // onTap: () {
                          //   if (_formKey.currentState!.validate()) {
                          //     register(context);
                          //   }
                          // }
                          ),
                      // SizedBox(s
                      //   height: 55,
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //       style: ButtonStyle(
                      //           backgroundColor: MaterialStateProperty.all(
                      //               Colors.blue.shade300)),
                      //       onPressed: () {
                      //         if (_formKey.currentState!.validate()) {
                      //           register(context);
                      //         }
                      //       },
                      //       child: Text(
                      //         'Login',
                      //         style: theme.textTheme.titleLarge?.copyWith(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold),
                      //       )),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account ?",
                              style: theme.textTheme.titleMedium),
                          TextButton(
                              // style: ButtonStyle(
                              //     backgroundColor: MaterialStateProperty.all(
                              //         Colors.blue.shade300)),
                              onPressed: () {
                                AppNavigator().push(context, RegisterScreen());
                              },
                              child:
                                  //  const CircularProgressIndicator()
                                  Text(
                                'Register',
                                style: theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.blue.shade300,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textfield(controller, name, validator) {
  return CupertinoTextFormFieldRow(
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.black12)),
      validator: validator,
      // padding: const EdgeInsets.all(15),
      controller: controller,
      placeholder: name);
}

// class TypeTextFieldComponent extends StatelessWidget {
//   final textInputAction;
//   final validator;
//   final controller;
//   final keyboardType;
//   final hintText;
//   final prefixIcon;
//   final suffixIcon;
//   // final obscureText;
//   const TypeTextFieldComponent({
//     super.key,
//     required this.textInputAction,
//     required this.validator,
//     required this.controller,
//     required this.keyboardType,
//     required this.hintText,
//     this.prefixIcon,
//     this.suffixIcon,
//     // this.obscureText
//   });

//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     return TextFormField(
//       style: theme.textTheme.subtitle2,
//       // obscureText: obscureText,
//       textInputAction: textInputAction,
//       validator: validator,
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.all(10),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           borderSide: BorderSide(
//             color: Colors.blue,
//           ),
//         ),
//         // border: const OutlineInputBorder(),
//         suffixIcon: suffixIcon,
//         prefixIcon: prefixIcon,
//         hintStyle: theme.textTheme.subtitle2!.copyWith(color: Colors.grey),
//         // enabledBorder: InputBorder.none,
//         // filled: true,
//         hintText: hintText,
//       ),
//     );
//   }
// }
