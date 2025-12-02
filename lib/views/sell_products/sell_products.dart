import 'dart:io';

import 'package:ecom_app/components/add_image_component.dart';
import 'package:ecom_app/components/alert_widget.dart';
import 'package:ecom_app/components/custom_image.dart';
import 'package:ecom_app/components/drawer.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/product_text_field.dart';
import 'package:ecom_app/components/size_component.dart';
import 'package:ecom_app/components/submit.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/sell_product_bloc/sell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SellProducts extends StatefulWidget {
  const SellProducts({super.key});

  @override
  State<SellProducts> createState() => _SellProductsState();
}

class _SellProductsState extends State<SellProducts> {
  File? image1;
  File? image2;
  File? image3;
  File? image4;
  File? image5;

  TextEditingController titleController = TextEditingController();

  TextEditingController subTitleController = TextEditingController();

  TextEditingController brandController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController descController = TextEditingController();

  TextEditingController smallController = TextEditingController();

  TextEditingController mediumController = TextEditingController();

  TextEditingController lgController = TextEditingController();

  TextEditingController xlController = TextEditingController();

  final _picker = ImagePicker();

  imagePicker(int index) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    switch (index) {
      case 1:
        image1 = File(pickedImage.path);
        break;
      case 2:
        image2 = File(pickedImage.path);
        break;
      case 3:
        image3 = File(pickedImage.path);
        break;
      case 4:
        image4 = File(pickedImage.path);
        break;
      case 5:
        image5 = File(pickedImage.path);
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Your Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(width(20)),
        child: SingleChildScrollView(
          child: Column(
            // main column
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // custom product fields

              Container(
                // padding: EdgeInsets.all(height(10)),
                decoration: BoxDecoration(
                    // color: const Color.fromARGB(255, 218, 217, 218),
                    // borderRadius: BorderRadius.circular(width(15)),
                    ),
                child: Column(
                  children: [
                    ProductTextField(
                      controller: titleController,
                      title: "Product Title",
                    ),
                    SizedBox(height: height(10)),
                    ProductTextField(
                      controller: subTitleController,
                      title: "Sub Title",
                    ),
                    SizedBox(height: height(10)),
                    ProductTextField(
                      controller: brandController,
                      title: "Brand of the Product",
                    ),
                    SizedBox(height: height(10)),
                    ProductTextField(
                      controller: priceController,
                      title: "Price",
                      inputType: TextInputType.number,
                      inputDigit: true,
                    ),
                    SizedBox(height: height(10)),
                    ProductTextField(
                      controller: descController,
                      title: "Description",
                      maxLines: 5,
                    ),
                  ],
                ),
              ),

              SizedBox(height: height(10)),
              MyText(title: "Available Sizes", fontSize: 16),
              SizedBox(height: height(10)),

              // custom size components
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                //   runAlignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizeComponent(
                    size: "S",
                    controller: smallController,
                  ),
                  SizeComponent(
                    size: "M",
                    controller: mediumController,
                  ),
                  SizeComponent(
                    size: "L",
                    controller: lgController,
                  ),
                  SizeComponent(
                    size: "Xl",
                    controller: xlController,
                  ),
                ],
              ),

              SizedBox(height: height(10)),
              MyText(title: "Add Images", fontSize: 16),
              SizedBox(height: height(5)),
              MyText(
                title:
                    "Add 5 images of your product with transperent background and in .png format",
                fontSize: 13,
                color: CustomStyles.lightGreyText,
              ),
              SizedBox(height: height(10)),
              // Image component

              // need to upload 5 images of the product with transperent background with png format

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    (image1 == null)
                        ? InkWell(
                            onTap: () {
                              imagePicker(1);
                            },
                            child: AddImageComponent())
                        : InkWell(
                            onTap: () {
                              imagePicker(1);
                            },
                            child: CustomImage(image: image1!)),
                    SizedBox(width: width(10)),
                    (image2 == null)
                        ? InkWell(
                            onTap: () {
                              imagePicker(2);
                            },
                            child: AddImageComponent())
                        : InkWell(
                            onTap: () {
                              imagePicker(2);
                            },
                            child: CustomImage(image: image2!)),
                    SizedBox(width: width(10)),
                    (image3 == null)
                        ? InkWell(
                            onTap: () {
                              imagePicker(3);
                            },
                            child: AddImageComponent())
                        : InkWell(
                            onTap: () {
                              imagePicker(3);
                            },
                            child: CustomImage(image: image3!)),
                    SizedBox(width: width(10)),
                    (image4 == null)
                        ? InkWell(
                            onTap: () {
                              imagePicker(4);
                            },
                            child: AddImageComponent())
                        : InkWell(
                            onTap: () {
                              imagePicker(4);
                            },
                            child: CustomImage(image: image4!)),
                    SizedBox(width: width(10)),
                    (image5 == null)
                        ? InkWell(
                            onTap: () {
                              imagePicker(5);
                            },
                            child: AddImageComponent())
                        : InkWell(
                            onTap: () {
                              imagePicker(5);
                            },
                            child: CustomImage(image: image5!)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Submit(
          submitText: "Add Product",
          onTap: () {
            if (titleController.text.isEmpty ||
                subTitleController.text.isEmpty ||
                priceController.text.isEmpty ||
                descController.text.isEmpty ||
                smallController.text.isEmpty ||
                mediumController.text.isEmpty ||
                lgController.text.isEmpty ||
                xlController.text.isEmpty ||
                image1 == null ||
                image2 == null ||
                image3 == null ||
                image4 == null ||
                image5 == null) {
              alertWidget(context,
                  "please fill all the required details and upload all the images");
            } else {
              context.read<SellProductsBloc>().add(SellProductsEvent(
                  title: titleController.text,
                  subTitle: subTitleController.text,
                  price: priceController.text,
                  desc: descController.text,
                  brand: brandController.text,
                  smallSize: smallController.text,
                  mdSize: mediumController.text,
                  lgSize: lgController.text,
                  xlSize: xlController.text,
                  img1: image1!,
                  img2: image2!,
                  img3: image3!,
                  img4: image4!,
                  img5: image5!));
            }
          }),
    );
  }
}
