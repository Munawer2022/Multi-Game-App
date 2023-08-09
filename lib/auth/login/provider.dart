import 'package:animation/auth/login/repository.dart';
import 'package:animation/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../dashboard.dart';
import '../../navigate.dart';

class LoginProvider extends ChangeNotifier {
  final box = GetStorage();

  bool _loading = false;
  bool get loading => _loading;

  loadingBotton(bool value) {
    _loading = value;
    notifyListeners();
  }

  dynamic errorShow;

  final LoginRepository loginRepository = LoginRepository();
  Future<dynamic> loginPostApiResponse(
      BuildContext context, dynamic data) async {
    loadingBotton(true);

    return await loginRepository.loginPostApiResponse(data).then((value) {
      snackbar(value['user'], context);
      // var snackBar = SnackBar(
      //   content: Text(value['user']),
      // );

      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      loadingBotton(false);
      AppNavigator().push(context, const Dahboard());
      debugPrint('\x1B[33m${value['token']}\x1B[0m');

      box.write('token', value['token']);
      box.write('name', value['name']);
      box.write('mobile_no', value['mobile_no']);
      // box.write('id', value['user']['id']);

      // box.write('first_name', value['user']['first_name']);
      // box.write('last_name', value['user']['last_name']);
      // box.write('profile', value['user']['profile']);
      // box.write('email', value['user']['email']);
      // box.write('phone_number', value['user']['phone_number']);
      // _response = value;
    }).onError((error, stackTrace) {
      loadingBotton(false);
      // errorShow = error.val('message');
      print(error);
      errorsnackBar(error.toString(), context);
      // if (kDebugMode) {
      //   print(error);
      // }
      // Utils().errorSnackBarMessage(error.toString(), context);
      notifyListeners();
    });
  }
}
