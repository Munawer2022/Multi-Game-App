import 'dart:convert';
import 'dart:io';

import 'package:animation/auth/login/login.dart';
import 'package:animation/auth/login/provider.dart';
import 'package:animation/auth/register/provider.dart';

import 'package:animation/dashboard.dart';
import 'package:animation/transfer/provider.dart';
import 'package:animation/utils.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../navigate.dart';

class TransferScreen extends StatefulWidget {
  TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _receiverCodeController = TextEditingController();

  final TextEditingController _coinsController = TextEditingController();

//   void register(BuildContext context) async {
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();

    checkBalance();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  int availableCoins = 0;
  void checkBalance() async {
    String date = DateTime.now().toString();
    var url = Uri.parse(
        "https://cybermaxuk.com/gamezone/game_backend/public/api/check-user-balance?userId=" +
            box.read('id').toString());

    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    });
    var responseData = json.decode(response.body);
    print(responseData['coin_balance']);
    String responseCoins = responseData['coin_balance'].toString();
    availableCoins =
        int.parse(responseCoins.substring(0, responseCoins.length - 3));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final transferController = Provider.of<TransferProvider>(context);

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        // await SystemNavigator.pop();
        Navigator.pop(context);
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
                            'Transfer Coins',
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
              SizedBox(
                height: 10,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/coin.png',
                      scale: 15,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    availableCoin(context, availableCoins)
                  ],
                ),
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
                        _receiverCodeController,
                        'Enter receiver code',
                        (value) {
                          if (value!.isEmpty) {
                            return 'Enter receiver code';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textfield(
                        _coinsController,
                        'Enter coins to transfer',
                        (value) {
                          if (value!.isEmpty) {
                            return 'Enter number of coins';
                          } else {
                            return null;
                          }
                        },
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      Button(
                          loading: transferController.loading,
                          title: 'Tranfer',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              transferController
                                  .transferPostApiResponse(context, {
                                'from_user_code': box.read('code'),
                                'to_user_code':
                                    _receiverCodeController.text.toString(),
                                'coin_type': '1',
                                'coins': _coinsController.text.toString(),
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text("Already have an account ?",
                      //         style: theme.textTheme.titleMedium),
                      //     TextButton(
                      //         // style: ButtonStyle(
                      //         //     backgroundColor: MaterialStateProperty.all(
                      //         //         Colors.blue.shade300)),
                      //         onPressed: () {
                      //           AppNavigator().push(context, LoginScreen());
                      //         },
                      //         child:
                      //             //  const CircularProgressIndicator()
                      //             Text(
                      //           'Login',
                      //           style: theme.textTheme.titleMedium?.copyWith(
                      //               color: Colors.blue.shade300,
                      //               fontWeight: FontWeight.bold),
                      //         ))
                      //   ],
                      // ),
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
      obscureText: name == "Password" ? true : false,
      keyboardType: name == "Enter coins to transfer"
          ? TextInputType.number
          : TextInputType.text,
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
