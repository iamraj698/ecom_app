import 'dart:convert';

import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/product_card.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/demo_wish_list.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/wish_list_bloc/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishList extends StatefulWidget {
  final void Function(int)? onItemTapped;
  const WishList({super.key, required this.onItemTapped});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<Map<String, dynamic>> prodList = [];
  late Map<String, dynamic> productJson;
  Set<int> wishlistedIndices = {};
  List wishlistId = [];
  int totalItems = 0;
  bool addToWishlist = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("wishlist initstate");
    // productJson = DemoWishList.productDetails;
    // for (var prod in productJson['products']) {
    //   prodList.add(prod);
    // }
    context.read<WishListBloc>().add(GetAllWishListIds());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WishListBloc, WishListState>(
          listener: (context, state) {
            setState(() {
              totalItems = state.product.length;
            });
            if (state.isWishListing == true) {
              addToWishlist = false;
            } else if (state.isWishListing == false) {
              addToWishlist = true;
            }
          },
        )
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: SafeArea(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width(7)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(
                              0xffF5F6FA,
                            ),
                            borderRadius: BorderRadius.circular(width(30))),
                        height: height(40),
                        width: width(40),
                        child: IconButton(
                            onPressed: () {
                              widget.onItemTapped!.call(0);
                            },
                            icon: Icon(
                              Icons.home_outlined,
                              size: 27,
                            ))),
                  ),
                  MyText(
                    title: "Wishlist",
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "./assets/images/appbar_assets/Cart.png",
                        height: height(45),
                        width: width(45),
                      )),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: width(15),
                      right: width(15),
                      bottom: height(10),
                      top: height(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "${totalItems} Items",
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          const MyText(
                            title: "in wishlist",
                            fontSize: 15,
                            color: Color(0xff8F959E),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.edit_outlined),
                          SizedBox(
                            width: width(10),
                          ),
                          const MyText(
                            title: "Edit",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  // padding: EdgeInsets.only(left: width(5), right: width(5)),
                  padding: EdgeInsets.all(width(20)),
                  child: BlocBuilder<WishListBloc, WishListState>(
                    builder: (context, state) {
                      if (state.product.isNotEmpty) {
                        final products = state.product;

                        wishlistId =
                            products.map((prod) => prod.productId).toList();

                        return Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: state.product.map((product) {
                            return ProductCard(
                              imagePath: product.bannerImage,
                              title: product.title,
                              price: "₹ " + product.price.toString(),
                              isWishlisted:
                                  wishlistId.contains(product.productId),
                              onWishlistToggle: () {
                                if (!addToWishlist) return;
                                context.read<WishListBloc>().add(
                                      AddToWishList(
                                        banner_image: product.bannerImage,
                                        title: product.title,
                                        price: product.price,
                                        productId: product.productId,
                                      ),
                                    );
                                // (addToWishlist == true)
                                //     ? context.read<WishListBloc>().add(
                                //         AddToWishList(
                                //             banner_image: product.bannerImage,
                                //             title: product.title,
                                //             price: product.price,
                                //             productId: product.productId))
                                //     : null;
                              },
                              onCardTap: () {
                                navigatorKey.currentState?.pushNamed(
                                    RouteNames.productDetails,
                                    arguments: {
                                      "product_id": product.productId,
                                      "selectedButton": "S"
                                    });
                              },
                            );
                          }).toList(),
                        );
                      } else {
                        return Text("No Products Are in the Wishlist");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
