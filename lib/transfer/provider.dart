import 'package:animation/auth/login/repository.dart';
import 'package:animation/auth/register/repository.dart';
import 'package:animation/navigate.dart';
import 'package:animation/transfer/repository.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../dashboard.dart';
import '../../utils.dart';

class TransferProvider extends ChangeNotifier {
  final box = GetStorage();

  bool _loading = false;
  bool get loading => _loading;

  loadingBotton(bool value) {
    _loading = value;
    notifyListeners();
  }

  dynamic errorShow;

  final TransferRepository transferRepository = TransferRepository();
  Future<dynamic> transferPostApiResponse(
      BuildContext context, dynamic data) async {
    loadingBotton(true);

    return await transferRepository.transferPostApiResponse(data).then((value) {
      loadingBotton(false);

      print(value);
      if (value['status'] == "Transferred") {
        snackbar('Transferred', context);
      } else if (value['message'] == "Insufficient funds") {
        snackbar('You have insufficient coins', context);
      } else if (value['message'] == "unable to found user from code") {
        snackbar('Receiver code invalid', context);
      }
      // if (value['status'] == "success") {
      //   box.write('token', value['token']);
      //   box.write('code', value['code']);
      //   box.write('mobile_no', value['mobile_no']);
      //   box.write('id', value['id']);
      //   box.write('name', value['name']);
      //   AppNavigator().push(context, const Dahboard());
      // }
    }).onError((error, stackTrace) {
      print(error.toString());
      errorsnackBar(error.toString(), context);
      loadingBotton(false);
      errorShow = error;
      // Utils().errorSnackBarMessage(error.toString(), context);
      notifyListeners();
    });
  }
}
