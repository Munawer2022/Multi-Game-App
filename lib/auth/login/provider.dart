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
      // snackbar(value['user'], context);
      // var snackBar = SnackBar(
      //   content: Text(value['user']),
      // );

      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      loadingBotton(false);
      print(value);
      if (value['status'] == "success") {
        box.write('token', value['token']);
        box.write('code', value['code']);
        box.write('mobile_no', value['mobile_no']);
        box.write('id', value['id']);
        box.write('name', value['name']);
        box.write('hourseNo', "0");
        box.write('biddingAmount', "0");
        box.write('bidInitiated', false);
        AppNavigator().push(context, const Dahboard());
      }
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
