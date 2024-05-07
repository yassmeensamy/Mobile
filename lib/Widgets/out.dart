
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class Out {
  Future <void> showDialog(BuildContext context, AlertType alertType, String title) async
  {
    Alert(
      context: context,
      type: alertType,
      title: title,
      //desc: ,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
