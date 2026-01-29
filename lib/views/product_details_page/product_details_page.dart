import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_app/components/alert_widget.dart';
import 'package:ecom_app/components/custom_row_title.dart';
import 'package:ecom_app/components/custom_size_btn.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/rating_star.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/app_constants.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/cart_bloc/cart.dart';
import 'package:ecom_app/view-models/product_detail_bloc/prod_details.dart';
import 'package:ecom_app/view-models/product_review_bloc/product_review.dart';
// import 'package:ecom_app/view-models/products_bloc/get_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel product;

  String? selectedButton;

  String sizeText = "Pieces are availabe";

  late Map sizeType;
  late Map<String, int> sizeMap = {};
  int qtyNum = 0;
  Color color = Colors.green;

  String? lastProductId;
  String? routeProductId; // image cache tracking
  Uint8List? img1Bytes;
  Uint8List? img2Bytes;
  Uint8List? img3Bytes;
  Uint8List? img4Bytes;
  Uint8List? img5Bytes;

  Uint8List? bannerBytes;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   final args =
  //       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

  //   if (args != null && selectedButton == null) {
  //     selectedButton = args["selectedButton"] ?? "S";
  //     final productId = args["product_id"];

  //     sizeType = {
  //       "S": "smQty",
  //       "M": "mdQty",
  //       "L": "lgQty",
  //       "XL": "xlQty",
  //     };

  //     context.read<ProductDetailBloc>().add(ClearProductDetail());

  //     context
  //         .read<ProductDetailBloc>()
  //         .add(GetSingleProductDetailEvent(product_id: productId));

  //     context
  //         .read<ProductReviewBloc>()
  //         .add(GetLatestSingleReview(productId: productId));

  //     context.read<ProductDetailBloc>().add(
  //           ProductCartIsExist(
  //             product_id: productId,
  //             qtyType: sizeType[selectedButton],
  //           ),
  //         );
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) return;

    final productId = args["product_id"];

    if (routeProductId == productId) return;

    routeProductId = productId;

    selectedButton = args["selectedButton"] ?? "S";

    // reset images
    img1Bytes = null;
    img2Bytes = null;
    img3Bytes = null;
    img4Bytes = null;
    img5Bytes = null;
    bannerBytes = null;
    lastProductId = null;

    sizeType = {
      "S": "smQty",
      "M": "mdQty",
      "L": "lgQty",
      "XL": "xlQty",
    };

    context.read<ProductDetailBloc>().add(ClearProductDetail());

    context
        .read<ProductDetailBloc>()
        .add(GetSingleProductDetailEvent(product_id: productId));

    context.read<ProductDetailBloc>().add(
          ProductCartIsExist(
            product_id: productId,
            qtyType: sizeType[selectedButton],
          ),
        );

    context
        .read<ProductReviewBloc>()
        .add(GetLatestSingleReview(productId: productId));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartProductError) {
                final route = ModalRoute.of(context);

                if (route != null && route.isCurrent) {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(
                      SnackBar(
                          content: MyText(
                        title: state.error.toString(),
                        fontSize: 14,
                        color: Colors.red,
                      )),
                    );
                }
              }
              if (state is CartStateSuccess) {
                // navigatorKey.currentState?.pushNamed(RouteNames.cart);
                context.read<ProductDetailBloc>().add(ProductCartIsExist(
                    product_id: product.id, qtyType: sizeType[selectedButton]));
              }
            },
          )
        ],
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            print(state);
            if (!state.hasFetched) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state.product == null) {
              return const Scaffold(
                body: Center(
                  child: MyText(title: "No Products", fontSize: 14),
                ),
              );
            } else if (state.product != null) {
              product = state.product!;

              sizeMap = {
                "S": product.smQty,
                "M": product.mdQty,
                "L": product.lgQty,
                "XL": product.xlQty,
              };

              if (lastProductId != product.id) {
                img1Bytes = base64Decode(product.img1);
                img2Bytes = base64Decode(product.img2);
                img3Bytes = base64Decode(product.img3);
                img4Bytes = base64Decode(product.img4);
                img5Bytes = base64Decode(product.img5);

                bannerBytes = img1Bytes;
                lastProductId = product.id;
              }

              qtyNum = sizeMap[selectedButton]!;
              color = qtyNum < 20 ? Colors.red : Colors.green;

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
                              bannerBytes!),
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
                                    // bannerBytes = base64Decode(product.img1);
                                  });
                                },
                                child: SizedBox(
                                  height: height(60),
                                  width: width(60),
                                  child: ClipRRect(
                                    child: Image.memory(
                                      // base64Decode(product.img1),
                                      img1Bytes!,
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
                                    // bannerBytes = base64Decode(product.img2);

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
                                        img2Bytes!,
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
                                    // bannerBytes = base64Decode(product.img3);

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
                                      img3Bytes!,
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
                                    // bannerBytes = base64Decode(product.img4);
                                  });
                                },
                                child: SizedBox(
                                  height: height(60),
                                  width: width(60),
                                  child: ClipRRect(
                                    child: Image.memory(
                                      // base64Decode(product.img4),
                                      img4Bytes!,
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
                                    // bannerBytes = base64Decode(product.img5);
                                  });
                                },
                                child: SizedBox(
                                  height: height(60),
                                  width: width(60),
                                  child: ClipRRect(
                                    child: Image.memory(
                                      // base64Decode(product.img5),
                                      img5Bytes!,
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
                              color:
                                  (selectedButton == "S") ? Colors.grey : null,
                              onTap: () {
                                // selected = !selected;
                                setState(() {
                                  selectedButton = "S";
                                  // _updateQtyAndColor();
                                  context.read<ProductDetailBloc>().add(
                                      ProductCartIsExist(
                                          product_id: product.id,
                                          qtyType: sizeType[selectedButton]));
                                });
                              },
                              // selected: selected,
                            ),
                            CustomSizeBtn(
                              title: "M",
                              color:
                                  (selectedButton == "M") ? Colors.grey : null,
                              onTap: () {
                                setState(() {
                                  selectedButton = "M";
                                  // _updateQtyAndColor();
                                  context.read<ProductDetailBloc>().add(
                                      ProductCartIsExist(
                                          product_id: product.id,
                                          qtyType: sizeType[selectedButton]));
                                });
                              },
                            ),
                            CustomSizeBtn(
                              title: "L",
                              color:
                                  (selectedButton == "L") ? Colors.grey : null,
                              onTap: () {
                                setState(() {
                                  selectedButton = "L";
                                  // _updateQtyAndColor();
                                  context.read<ProductDetailBloc>().add(
                                      ProductCartIsExist(
                                          product_id: product.id,
                                          qtyType: sizeType[selectedButton]));
                                });
                              },
                            ),
                            CustomSizeBtn(
                              title: "XL",
                              color:
                                  (selectedButton == "XL") ? Colors.grey : null,
                              onTap: () {
                                setState(() {
                                  selectedButton = "XL";
                                  // _updateQtyAndColor();
                                  context.read<ProductDetailBloc>().add(
                                      ProductCartIsExist(
                                          product_id: product.id,
                                          qtyType: sizeType[selectedButton]));
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
                                        title: sizeMap[selectedButton]!
                                                .toString() +
                                            " " +
                                            sizeText,
                                        fontSize: 17,
                                        // color: qtyNum < 20
                                        //     ? Colors.red
                                        //     : Colors.green,
                                        color: color,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height(15))
                                ],
                              )
                            : const SizedBox(),

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
                                  return const CircularProgressIndicator();
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
                                                        color: CustomStyles
                                                            .lightGreyText,
                                                      ),
                                                      SizedBox(
                                                        width: width(4),
                                                      ),
                                                      MyText(
                                                        title: DateFormat(
                                                                "dd-MM-yyyy")
                                                            .format(DateTime
                                                                .parse(review
                                                                    .addedOn)),
                                                        fontSize: 11,
                                                        color: CustomStyles
                                                            .lightGreyText,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
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
                                                children:
                                                    List.generate(5, (index) {
                                                  return RatingStar(
                                                    color: index <
                                                            int.parse(
                                                                review.rating)
                                                        ? Colors.amber
                                                        : CustomStyles
                                                            .lightGreyText,
                                                  );
                                                }),
                                              ),
                                              SizedBox(
                                                height: height(5),
                                              ),
                                              (review.userId ==
                                                      AppConstants.user!.uid)
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    ProductReviewBloc>()
                                                                .add(DeleteReview(
                                                                    reviewId:
                                                                        review
                                                                            .id,
                                                                    productID:
                                                                        product
                                                                            .id));
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            size: height(17),
                                                            color: CustomStyles
                                                                .danger,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height(8),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              review.review,
                                              style: TextStyle(
                                                color:
                                                    CustomStyles.lightGreyText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
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
                                } else if (state
                                    is ProductDeleteReviewSuccess) {
                                  context.read<ProductReviewBloc>().add(
                                      GetLatestSingleReview(
                                          productId: product.id));
                                }

                                return const SizedBox();
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

                // add to cart btn
                bottomNavigationBar: (sizeMap[selectedButton] != 0)
                    ? BlocBuilder<ProductDetailBloc, ProductDetailState>(
                        builder: (context, state) {
                          print("Is In cart value ${state.isInCart}");
                          print("___________________________");
                          print(state.cartFetched);
                          if (!state.cartFetched) {
                            // return CircularProgressIndicator();
                            return Material(
                              color: CustomStyles.submit,
                              child: Container(
                                  width: double.infinity,
                                  height: height(60),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  )),
                            );
                          } else if (state.isInCart) {
                            return Material(
                              color: CustomStyles.submit,
                              child: InkWell(
                                splashColor: CustomStyles.submit,
                                onTap: () {
                                  print("Go to cart");
                                  navigatorKey.currentState
                                      ?.pushNamed(RouteNames.cart);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: height(60),
                                  child: Center(
                                    child: BlocBuilder<CartBloc, CartState>(
                                        builder: (context, state) {
                                      if (state is CartStateLoading) {
                                        return const CircularProgressIndicator();
                                      }
                                      return MyText(
                                        title: "Go to Cart",
                                        fontSize: 17,
                                        color: CustomStyles.textWhite,
                                        fontWeight: FontWeight.w500,
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            );
                          } else if (state.isInCart == false) {
                            return Material(
                              color: CustomStyles.submit,
                              child: InkWell(
                                splashColor: CustomStyles.submit,
                                onTap: () {
                                  print("add to cart");
                                  // triggering event to add the present item user[cart] and navigating
                                  //  to the user cart page with all cart products

                                  if (sizeMap[selectedButton] == 0) {
                                    alertWidget(context, "Out of Stock");
                                    return;
                                  }

                                  context.read<CartBloc>().add(AddCartProduct(
                                        productId: product.id,
                                        title: product.productTitle,
                                        priceAtTime: product.price,
                                        createdAt: DateTime.now().toString(),
                                        quantity: 1,
                                        qtyType: sizeType[selectedButton],
                                        banner_image: product.img1,
                                      ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: height(60),
                                  child: Center(
                                    child: BlocBuilder<CartBloc, CartState>(
                                        builder: (context, state) {
                                      if (state is CartStateLoading) {
                                        return const CircularProgressIndicator();
                                      }
                                      return MyText(
                                        title: "Add to Cart",
                                        fontSize: 17,
                                        color: CustomStyles.textWhite,
                                        fontWeight: FontWeight.w500,
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            );
                          }
                          return SizedBox();
                        },
                      )
                    : SizedBox(),
              );
            } else {
              return SizedBox();
            }
          },
        ));
  }
}
