import 'package:ecom_app/main.dart';
import 'package:flutter/material.dart';

void alertWidget(BuildContext context, String error,
    {Color? textColor = Colors.red, String title = "Error"}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  error,
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                print("clicked");
                navigatorKey.currentState?.pop();
              },
              child: Text("OK"))
        ],
      );
    },
  );
}
