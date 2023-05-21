

import 'package:smart_home/lib.dart';

Future showLoadingDialog(context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: const Center(
        child: CircularProgressIndicator()
      ),
    ),
  );
}