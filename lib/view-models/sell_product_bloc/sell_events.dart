import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SellEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class SellProductsEvent extends SellEvents {
  SellProductsEvent(
      {required this.title,
      required this.subTitle,
      this.brand,
      required this.price,
      required this.desc,
      required this.smallSize,
      required this.mdSize,
      required this.lgSize,
      required this.xlSize,
      required this.img1,
      required this.img2,
      required this.img3,
      required this.img4,
      required this.img5});
  String title;
  String subTitle;
  String? brand;
  int price;
  String desc;
  int smallSize;
  int mdSize;
  int lgSize;
  int xlSize;
  File img1;
  File img2;
  File img3;
  File img4;
  File img5;
}
