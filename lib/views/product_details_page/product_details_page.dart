import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_app/components/custom_row_title.dart';
import 'package:ecom_app/components/custom_size_btn.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/rating_star.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String? banner_image;
  late int qtyNum;
  late ProductModel product;
  late Map sizeMap;
  late Color color;

  late var img1Bytes;
  late var img2Bytes;
  late var img3Bytes;
  late var img4Bytes;
  late var img5Bytes;
  late var bannerBytes;

  bool selected = false;
  var selectedButton = "S";
  String sizeText = "Pieces are availabe";
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final settings = ModalRoute.of(context)!.settings;
    product = settings.arguments as ProductModel;
    sizeMap = {
      "S": product.smQty,
      "M": product.mdQty,
      "L": product.lgQty,
      "XL": product.xlQty,
    };
    _updateQtyAndColor();
    // qtyNum = int.parse(sizeMap[selectedButton]);
    // if (qtyNum < 20) {
    //   color = Colors.red;
    // } else {
    //   color = Colors.green;
    // }

    img1Bytes = base64Decode(product.img1);
    img2Bytes = base64Decode(product.img2);
    img3Bytes = base64Decode(product.img3);
    img4Bytes = base64Decode(product.img4);
    img5Bytes = base64Decode(product.img5);

    // // Set only once
    // banner_image ??= product.img1;
    bannerBytes = img1Bytes;
  }

  void _updateQtyAndColor() {
    qtyNum = int.parse(sizeMap[selectedButton]);
    color = qtyNum < 20 ? Colors.red : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              "./assets/images/appbar_assets/Cart.png",
              height: height(45),
              width: width(45),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width(20)),
          child: Column(
            // parent column
            children: [
              SizedBox(
                width: double.infinity,
                height: height(350),
                child: Image.memory(
                    // base64Decode(banner_image!),
                    bannerBytes),
                // child: Image.asset(
                //   "assets/images/prod_details/${banner_image}",
                //   height: height(350),
                //   // fit: BoxFit.cover,
                // ),
              ),
              SizedBox(
                height: height(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: product.productTitle,
                        fontSize: 13,
                        color: CustomStyles.lightGreyText,
                      ),
                      MyText(
                        title: product.subTitle,
                        fontSize: 22,
                        color: CustomStyles.textBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyText(
                            title: "Price",
                            fontSize: 13,
                            color: CustomStyles.lightGreyText,
                          ),
                        ],
                      ),
                      MyText(
                        title: "₹ " + product.price,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: height(10),
              ),
              //multiple images

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          // banner_image = product.img1;
                          bannerBytes = img1Bytes;
                        });
                      },
                      child: SizedBox(
                        height: height(60),
                        width: width(60),
                        child: ClipRRect(
                          child: Image.memory(
                            // base64Decode(product.img1),
                            img1Bytes,
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child: Image.asset(
                        //   "assets/images/prod_details/banner_image.png",
                        // ),
                      ),
                    ),
                    SizedBox(
                      width: width(10),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          // banner_image = product.img2;
                          bannerBytes = img2Bytes;

                          // print("banner changed");
                          // print(banner_image);
                        });
                      },
                      child: InkWell(
                        child: SizedBox(
                          height: height(60),
                          width: width(60),
                          child: ClipRRect(
                            child: Image.memory(
                              // base64Decode(product.img2),
                              img2Bytes,
                              fit: BoxFit.fill,
                            ),
                          ),
                          // child: Image.asset(
                          //   "assets/images/prod_details/image_1.png",
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width(10),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          // banner_image = product.img3;
                          bannerBytes = img3Bytes;

                          // print("banner changed");
                          // print(banner_image);
                        });
                      },
                      child: SizedBox(
                        height: height(60),
                        width: width(60),
                        child: ClipRRect(
                          child: Image.memory(
                            // base64Decode(product.img3),
                            img3Bytes,
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child: Image.asset(
                        //   "assets/images/prod_details/image_2.png",
                        // )
                      ),
                    ),
                    SizedBox(
                      width: width(10),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          // banner_image = product.img4;
                          bannerBytes = img4Bytes;
                        });
                      },
                      child: SizedBox(
                        height: height(60),
                        width: width(60),
                        child: ClipRRect(
                          child: Image.memory(
                            // base64Decode(product.img4),
                            img4Bytes,
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child: Image.asset(
                        //   "assets/images/prod_details/image_3.png",
                        // ),
                      ),
                    ),
                    SizedBox(
                      width: width(10),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          // banner_image = product.img5;
                          bannerBytes = img5Bytes;
                        });
                      },
                      child: SizedBox(
                        height: height(60),
                        width: width(60),
                        child: ClipRRect(
                          child: Image.memory(
                            // base64Decode(product.img5),
                            img5Bytes,
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child: Image.asset(
                        //   "assets/images/prod_details/image_4.png",
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height(15),
              ),

              CustomRowTitle(title: "Size", subTitle: "Size Guide"),
              SizedBox(
                height: height(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSizeBtn(
                    title: "S",
                    color: (selectedButton == "S") ? Colors.grey : null,
                    onTap: () {
                      // selected = !selected;
                      setState(() {
                        selectedButton = "S";
                        _updateQtyAndColor();
                      });
                    },
                    // selected: selected,
                  ),
                  CustomSizeBtn(
                    title: "M",
                    color: (selectedButton == "M") ? Colors.grey : null,
                    onTap: () {
                      setState(() {
                        selectedButton = "M";
                        _updateQtyAndColor();
                      });
                    },
                  ),
                  CustomSizeBtn(
                    title: "L",
                    color: (selectedButton == "L") ? Colors.grey : null,
                    onTap: () {
                      setState(() {
                        selectedButton = "L";
                        _updateQtyAndColor();
                      });
                    },
                  ),
                  CustomSizeBtn(
                    title: "XL",
                    color: (selectedButton == "XL") ? Colors.grey : null,
                    onTap: () {
                      setState(() {
                        selectedButton = "XL";
                        _updateQtyAndColor();
                      });
                    },
                  ),
                  // CustomSizeBtn(title: "2Xl"),
                ],
              ),

              SizedBox(
                height: height(15),
              ),
              (selectedButton != null)
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              title: sizeMap[selectedButton]! + " " + sizeText,
                              fontSize: 17,
                              // color: qtyNum < 20 ? Colors.red : Colors.green,
                              color: color,
                            ),
                          ],
                        ),
                        SizedBox(height: height(15))
                      ],
                    )
                  : SizedBox(),

              // SizedBox(
              //   height: height(15),
              // ),
              // description

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        title: "Description",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(5),
                  ),
                  MyText(
                    title: product.description,
                    // title:
                    //     "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with ",
                    fontSize: 15,
                    color: CustomStyles.lightGreyText,
                  )
                ],
              ),

              SizedBox(
                height: height(15),
              ),

              // Reviews in product view

              Column(
                children: [
                  CustomRowTitle(title: "Review", subTitle: "View All"),
                  SizedBox(
                    height: height(13),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: height(40),
                              width: width(40),
                              child: Image.asset(
                                  "./assets/images/prod_details/reviewer.png")),
                          SizedBox(
                            width: width(7),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MyText(
                                title: "Ronald Richards",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: height(2),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: CustomStyles.lightGreyText,
                                  ),
                                  SizedBox(
                                    width: width(4),
                                  ),
                                  MyText(
                                    title: "13 Sep, 2020",
                                    fontSize: 11,
                                    color: CustomStyles.lightGreyText,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const MyText(
                                title: "4.8",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                width: width(3),
                              ),
                              MyText(
                                title: "rating",
                                fontSize: 13,
                                color: CustomStyles.lightGreyText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: height(2),
                          ),
                          Row(
                            children: [
                              RatingStar(),
                              RatingStar(),
                              RatingStar(),
                              RatingStar(),
                              RatingStar(
                                color: CustomStyles.lightGreyText,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(8),
                  ),
                  MyText(
                    title:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
                    fontSize: 15,
                    color: CustomStyles.lightGreyText,
                  )
                ],
              ),

              // total price
              SizedBox(
                height: height(15),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyText(
                        title: "Total Price",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        title: "with VAT/SD",
                        fontSize: 11,
                        color: CustomStyles.lightGreyText,
                      )
                    ],
                  ),
                  MyText(
                    title: "₹ " + product.price,
                    // title: "\$125",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Add to Cart Btn
      bottomNavigationBar: Material(
        color: CustomStyles.submit,
        child: InkWell(
          splashColor: CustomStyles.submit,
          onTap: () {
            print("add to cart");
            navigatorKey.currentState?.pushNamed(RouteNames.cart);
          },
          child: Container(
            width: double.infinity,
            height: height(60),
            child: Center(
                child: MyText(
              title: "Add to Cart",
              fontSize: 17,
              color: CustomStyles.textWhite,
              fontWeight: FontWeight.w500,
            )),
          ),
        ),
      ),
    );
  }
}
