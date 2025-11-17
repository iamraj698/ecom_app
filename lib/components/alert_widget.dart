import 'package:ecom_app/main.dart';
import 'package:flutter/material.dart';

void alertWidget(BuildContext context, String error) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(color: Colors.red),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red),
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
