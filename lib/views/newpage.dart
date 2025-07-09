import 'package:flutter/material.dart';

class Newpage extends StatelessWidget {
  Newpage({super.key, required this.personName, this.age});
  String personName;
  String? age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(personName),
            const Text("NewPage"),
          ],
        ),
      ),
    );
  }
}
