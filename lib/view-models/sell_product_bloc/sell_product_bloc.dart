import 'dart:io';

import 'package:ecom_app/data/repositories/product_repository.dart';
import 'package:ecom_app/utils/file_compress_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sell.dart';

class SellProductsBloc extends Bloc<SellEvents, SellState> {
  ProductRepository _productRepository = ProductRepository();
  SellProductsBloc() : super(SellInitialState()) {
    on<SellProductsEvent>(_mapAddToFirebase);
  }

  void _mapAddToFirebase(
      SellProductsEvent event, Emitter<SellState> emit) async {
    emit(SellAddPrdLoading());
    print("inside the sell product bloc");
    String title = event.title;
    String subTitle = event.subTitle;
    int price = event.price;
    String? brand = event.brand;
    String desc = event.desc;
    int smallCount = event.smallSize;
    int largeCount = event.lgSize;
    int mediumCount = event.mdSize;
    int xlCount = event.xlSize;
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

    final res = await _productRepository.addProduct(
        title,
        subTitle,
        brand,
        price,
        desc,
        smallCount,
        mediumCount,
        largeCount,
        xlCount,
        base64img1,
        base64img2,
        base64img3,
        base64img4,
        base64img5);
    if (res == "success") {
      emit(SellAddProdSuccess());
    } else {
      emit(SellAddProdError(error: res.toString()));
    }
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

    // print("Base64: $base64Str");

    return base64Str;
  }
}
