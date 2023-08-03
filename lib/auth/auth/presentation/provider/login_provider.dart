import 'package:flutter/material.dart';

import '../../data/repositories/login_respository.dart';

class LoginProvider extends ChangeNotifier {
  // final box = GetStorage();
  bool _isVisible = false;
  bool get isVisible => _isVisible;

  bool _loading = false;
  bool get loading => _loading;

  // dynamic _response;
  // dynamic get response => _response;

  hideicon() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  loadingBotton(bool value) {
    _loading = value;
    notifyListeners();
  }

  dynamic errorShow;
  // String get error => _error;
  final LoginRepository loginRepository = LoginRepository();
  Future<dynamic> loginPostApiResponse(
      BuildContext context, dynamic data) async {
    loadingBotton(true);

    return await loginRepository.loginPostApiResponse(data).then((value) {
      loadingBotton(false);
      // Navigator.pushNamed(
      //   context,
      //   RoutesName.bottomnavdashboard,
      // );
      debugPrint(value['token']);
      // box.write('token', value['token']);
      // box.write('id', value['user']['id']);

      // box.write('first_name', value['user']['first_name']);
      // box.write('last_name', value['user']['last_name']);
      // box.write('profile', value['user']['profile']);
      // box.write('email', value['user']['email']);
      // box.write('phone_number', value['user']['phone_number']);
      // _response = value;
    }).onError((error, stackTrace) {
      loadingBotton(false);
      errorShow = error;
      // Utils().errorSnackBarMessage(error.toString(), context);
      notifyListeners();
    });
  }
}
