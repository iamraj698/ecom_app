import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

void loadingWidget(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
          padding: EdgeInsets.only(
              left: width(100),
              right: width(100),
              top: height(60),
              bottom: height(60)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: height(30),
                  width: width(30),
                  child: CircularProgressIndicator()),
              SizedBox(
                height: 20,
              ),
              Text(
                "Loading",
                style: TextStyle(fontSize: 12, color: Colors.black),
              )
            ],
          )),
    ),
  );
}
