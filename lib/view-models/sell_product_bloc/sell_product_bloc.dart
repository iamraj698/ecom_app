import 'dart:io';

import 'package:ecom_app/utils/file_compress_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sell.dart';

class SellProductsBloc extends Bloc<SellEvents, SellState> {
  SellProductsBloc() : super(SellInitialState()) {
    on<SellProductsEvent>(_mapAddToFirebase);
  }

  void _mapAddToFirebase(
      SellProductsEvent event, Emitter<SellState> emit) async {
    print("inside the sell product bloc");
    String title = event.title;
    String subTitle = event.subTitle;
    String price = event.price;
    String? brand = event.brand;
    String smallCount = event.smallSize;
    String largeCount = event.lgSize;
    String mediumCount = event.mdSize;
    String xlCount = event.xlSize;
    File img1 = event.img1;
    File img2 = event.img2;
    File img3 = event.img3;
    File img4 = event.img4;
    File img5 = event.img5;

    String base64img1 = await compressAndConvert(img1);
    String base64img2 = await compressAndConvert(img2);
    String base64img3 = await compressAndConvert(img3);
    String base64img4 = await compressAndConvert(img4);
    String base64img5 = await compressAndConvert(img5);

  }

  Future<String> compressAndConvert(File file) async {
    // Step 1: Compress image
    File? compressed = await compressImage(file);

    if (compressed == null) {
      print("Compression failed");
      return "";
    }

    // Step 2: Convert to Base64
    String base64Str = await fileToBase64(compressed);

    print("Base64: $base64Str");

    return base64Str;
  }
}
