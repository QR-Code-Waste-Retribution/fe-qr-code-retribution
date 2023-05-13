import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class AlertDialogCustom {

  static Future<void> showAlertDialog(
      {required BuildContext context,
      required void Function()? onYes,
      required String title,
      required String content}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: Text(
            title,
            style: blackTextStyle,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  content,
                  style: blackTextStyle,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Tidak',
                style: blackTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: onYes,
              child: Text(
                'Ya',
                style: blackTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }
  
}
