import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_app/components/alert_widget.dart';
import 'package:ecom_app/components/custom_row_title.dart';
import 'package:ecom_app/components/custom_size_btn.dart';
import 'package:ecom_app/components/drawer.dart';
import 'package:ecom_app/components/loding_widget.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/rating_star.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/app_constants.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/cart_bloc/cart.dart';
import 'package:ecom_app/view-models/product_review_bloc/product_review.dart';
import 'package:ecom_app/view-models/products_bloc/get_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  late Map sizeType;
  String errorMessage = "";

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

    sizeType = {
      "S": "smQty",
      "M": "mdQty",
      "L": "lgQty",
      "XL": "xlQty",
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

    if (product.id != "") {
      context
          .read<ProductReviewBloc>()
          .add(GetLatestSingleReview(productId: product.id));
    }
  }

  void _updateQtyAndColor() {
    // qtyNum = int.parse(sizeMap[selectedButton].toString());
    qtyNum = sizeMap[selectedButton];
    color = qtyNum < 20 ? Colors.red : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        print(state);
        if (state is CartProductError) {
          navigatorKey.currentState?.pop();
          alertWidget(context, state.error);
          errorMessage = state.error;
        } else if (state is CartStateLoading) {
          loadingWidget(context);
        } else if (state is CartStateSuccess) {
          navigatorKey.currentState?.pop();
          navigatorKey.currentState?.pushNamed("cart");
        }else if( state is CartLoaded){}
      },
      child: Scaffold(
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
                          title: "₹ " + product.price.toString(),
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
                (selectedButton != "")
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                title: sizeMap[selectedButton]!.toString() +
                                    " " +
                                    sizeText,
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
                    InkWell(
                        onTap: () {
                          navigatorKey.currentState?.pushNamed(
                              RouteNames.productReview,
                              arguments: {"productId": product.id});
                        },
                        child: CustomRowTitle(
                            title: "Review", subTitle: "View All")),
                    SizedBox(
                      height: height(13),
                    ),
                    BlocBuilder<ProductReviewBloc, ProductReviewState>(
                      builder: (context, state) {
                        print(state);
                        if (state is ProductReviewLoading) {
                          return CircularProgressIndicator();
                        } else if (state is LatestReviewFetched) {
                          // only Review column

                          final review = state.review;

                          // print(review.);

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                            title: review.userName,
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
                                                color:
                                                    CustomStyles.lightGreyText,
                                              ),
                                              SizedBox(
                                                width: width(4),
                                              ),
                                              MyText(
                                                title: DateFormat("dd-MM-yyy")
                                                    .format(DateTime.parse(
                                                        review.addedOn)),
                                                fontSize: 11,
                                                color:
                                                    CustomStyles.lightGreyText,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //      MyText(
                                      //       title: rev.rating,
                                      //       fontSize: 15,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //     SizedBox(
                                      //       width: width(3),
                                      //     ),
                                      //     MyText(
                                      //       title: "rating",
                                      //       fontSize: 13,
                                      //       color: CustomStyles.lightGreyText,
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: height(2),
                                      // ),
                                      Row(
                                        children: List.generate(5, (index) {
                                          return RatingStar(
                                            color: index <
                                                    int.parse(review.rating)
                                                ? Colors.amber
                                                : CustomStyles.lightGreyText,
                                          );
                                        }),
                                      ),
                                      SizedBox(
                                        height: height(5),
                                      ),
                                      (review.userId == AppConstants.user!.uid)
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            ProductReviewBloc>()
                                                        .add(DeleteReview(
                                                            reviewId: review.id,
                                                            productID:
                                                                product.id));
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: height(17),
                                                    color: CustomStyles.danger,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height(8),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      review.review,
                                      style: TextStyle(
                                        color: CustomStyles.lightGreyText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );

                          // return Column(
                          //   children: [
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //                 height: height(40),
                          //                 width: width(40),
                          //                 child: Image.asset(
                          //                     "./assets/images/prod_details/reviewer.png")),
                          //             SizedBox(
                          //               width: width(7),
                          //             ),
                          //             Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 MyText(
                          //                   title: review.userName,
                          //                   fontSize: 15,
                          //                   fontWeight: FontWeight.w600,
                          //                 ),
                          //                 SizedBox(
                          //                   height: height(2),
                          //                 ),
                          //                 Row(
                          //                   children: [
                          //                     Icon(
                          //                       Icons.access_time,
                          //                       color: CustomStyles.lightGreyText,
                          //                     ),
                          //                     SizedBox(
                          //                       width: width(4),
                          //                     ),
                          //                     MyText(
                          //                       title: DateFormat("dd-MM-yyyy")
                          //                           .format(DateTime.parse(
                          //                               review.addedOn)),
                          //                       fontSize: 11,
                          //                       color: CustomStyles.lightGreyText,
                          //                     )
                          //                   ],
                          //                 )
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //         Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 const MyText(
                          //                   title: "4.8",
                          //                   fontSize: 15,
                          //                   fontWeight: FontWeight.w600,
                          //                 ),
                          //                 SizedBox(
                          //                   width: width(3),
                          //                 ),
                          //                 MyText(
                          //                   title: "rating",
                          //                   fontSize: 13,
                          //                   color: CustomStyles.lightGreyText,
                          //                 )
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: height(2),
                          //             ),
                          //             Row(
                          //               children: [
                          //                 RatingStar(),
                          //                 RatingStar(),
                          //                 RatingStar(),
                          //                 RatingStar(),
                          //                 RatingStar(
                          //                   color: CustomStyles.lightGreyText,
                          //                 ),
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: height(8),
                          //     ),
                          //     MyText(
                          //       title:
                          //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
                          //       fontSize: 15,
                          //       color: CustomStyles.lightGreyText,
                          //     )
                          //   ],
                          // );
                        } else if (state is LatestReviewFetchedZero) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "There are No Reviews Click on View All to Add Yours",
                                  style: TextStyle(
                                    color: CustomStyles.lightGreyText,
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (state is ProductDeleteReviewSuccess) {
                          context.read<ProductReviewBloc>().add(
                              GetLatestSingleReview(productId: product.id));
                        }

                        return SizedBox();
                      },
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
                      title: "₹ " + product.price.toString(),
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
        bottomNavigationBar: (sizeMap[selectedButton] != 0)
            ? Material(
                color: CustomStyles.submit,
                child: InkWell(
                  splashColor: CustomStyles.submit,
                  onTap: () {
                    print("add to cart");
                    // triggering event to add the present item user[cart] and navigating
                    //  to the user cart page with all cart products

                    context.read<CartBloc>().add(AddCartProduct(
                          productId: product.id,
                          title: product.productTitle,
                          priceAtTime: product.price,
                          createdAt: DateTime.now().toString(),
                          quantity: 1,
                          qtyType: sizeType[selectedButton],
                          banner_image: product.img1,
                        ));

                    if (sizeMap[selectedButton] == 0) {
                      return alertWidget(context, "Out of Stock");
                    }
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
              )
            : SizedBox(),
      ),
    );
  }
}
