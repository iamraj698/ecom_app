import 'dart:convert';

import 'package:ecom_app/components/cart_address_component.dart';
import 'package:ecom_app/components/cart_product_card.dart';
import 'package:ecom_app/components/cart_total_component.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/cart_item_model/cart_item_model.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/cart_bloc/cart.dart';
import 'package:ecom_app/view-models/cart_stream_bloc/cart_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map sizeChart = {
    "smQty": "S",
    "mdQty": "M",
    "lgQty": "L",
    "xlQty": "Xl",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<CartStreamBloc>().add(FetchCartItems());
  }

  @override
  Widget build(BuildContext context) {
    List demolist = [
      "1",
      "2",
      "3",
      "1",
      "2",
      "3",
      "1",
      "2",
      "3",
      "1",
      "2",
      "3",
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cart"),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              print(state);
              if (state is CartProductError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width(20)),
            child: Column(
              // parent column
              children: [
                BlocBuilder<CartStreamBloc, CartStreamState>(
                  builder: (context, state) {
                    if (state is CartStreamLoaded) {
                      final List<CartItemModel> cartProducts = state.cartItems;

                      List<int> prices = [];
                      int finalTotal = 0;

                      for (var prod in state.cartItems) {
                        prices.add(prod.price * prod.quantity);
                      }
                      print("___________________________");

                      for (var total in prices) {
                        finalTotal = finalTotal + total;
                        print(finalTotal);
                      }

                      if (cartProducts.isNotEmpty) {
                        return Column(
                          children: [
                            ListView.builder(
                              itemCount: cartProducts.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    print(
                                        sizeChart[cartProducts[index].qtyType]);
                                    navigatorKey.currentState?.pushNamed(
                                        RouteNames.productDetails,
                                        arguments: {
                                          "product_id": cartProducts[index]
                                              .id
                                              .split("_")
                                              .first,
                                          "selectedButton": sizeChart[
                                              cartProducts[index].qtyType],
                                        });
                                  },
                                  child: CartProductCard(
                                    banner_image: Image.memory(
                                      cartProducts[index].image,
                                      gaplessPlayback: true,
                                    ),
                                    title: cartProducts[index].title,
                                    size:
                                        sizeChart[cartProducts[index].qtyType],
                                    price: "Rs " +
                                        cartProducts[index].price.toString(),
                                    quantity:
                                        cartProducts[index].quantity.toString(),
                                    onDelete: () {
                                      context.read<CartBloc>().add(
                                          DeleteCartItem(
                                              cartProdId:
                                                  cartProducts[index].id));
                                    },
                                    onIncrement: () {
                                      context.read<CartBloc>().add(
                                          IncrementCartItem(
                                              cartProdId:
                                                  cartProducts[index].id));
                                    },
                                    onDecrement: () {
                                      print("decrement pressed");
                                      context.read<CartBloc>().add(
                                          DecrementCartItem(
                                              cartProdId:
                                                  cartProducts[index].id));
                                    },
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: height(10),
                            ),

                            // Delivery Address & Payment Method Column

                            Column(
                              children: [
                                CartAddressComponent(
                                  onTapSeeAll: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: height(400),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: CustomStyles.cartImagBack,
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(width(100)),
                                                topRight:
                                                    Radius.circular(width(100)),
                                              )),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                  // shrinkWrap: true,
                                                  itemCount: demolist.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding: EdgeInsets.all(
                                                          width(15)),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.person,
                                                                size:
                                                                    height(30),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    width(10),
                                                              ),
                                                              const MyText(
                                                                title:
                                                                    "Rajesab Muddebihal",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.phone,
                                                                size:
                                                                    height(30),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    width(10),
                                                              ),
                                                              const MyText(
                                                                  title:
                                                                      "990011332",
                                                                  fontSize: 14)
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                size:
                                                                    height(30),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    width(10),
                                                              ),
                                                              const Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  MyText(
                                                                      title:
                                                                          "Near Dargha Alampur pete Ilkal.",
                                                                      fontSize:
                                                                          14),
                                                                  MyText(
                                                                      title:
                                                                          "Ilkal,Karnataka. 587154.",
                                                                      fontSize:
                                                                          14)
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                    // return ListTile(
                                                    //   title: MyText(title: "Rajesab Muddebihal", fontSize: 14, fontWeight: FontWeight.bold,),
                                                    //   subtitle: MyText(title: "", fontSize: fontSize),
                                                    // );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  leading: Container(
                                      // color: CustomStyles.lightGreyText,
                                      // padding: const EdgeInsets.all(10),
                                      height: height(50),
                                      width: width(50),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            "./assets/images/card_address/map.png",
                                            // height: height(50),
                                            // fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                              child: Container(
                                            height: height(20),
                                            width: width(20),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffFF7043),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Image.asset(
                                              "./assets/images/card_address/Location.png",
                                            ),
                                          ))
                                        ],
                                      )),
                                  heading: "Delivery Address",
                                  title: "Chhatak, Sunamgonj 12/8AB",
                                  subTitle: "Sylhet",
                                  trailing: Container(
                                      height: height(25),
                                      width: width(25),
                                      decoration: BoxDecoration(
                                          color: CustomStyles.checkBack,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: const Icon(Icons.check)),
                                ),
                                SizedBox(
                                  height: height(10),
                                ),
                                CartAddressComponent(
                                  onTapSeeAll: () {},
                                  leading: Container(
                                    // color: CustomStyles.lightGreyText,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xffF5F6FA)),
                                    padding: const EdgeInsets.all(10),
                                    height: height(50),
                                    width: width(50),
                                    child: Image.asset(
                                      "./assets/images/card_address/visa.png",
                                      // height: height(50),
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  heading: "Payment Method",
                                  title: "Visa Classic",
                                  subTitle: "**** 7690",
                                  trailing: Container(
                                      height: height(25),
                                      width: width(25),
                                      decoration: BoxDecoration(
                                          color: CustomStyles.checkBack,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: const Icon(Icons.check)),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: height(15),
                            ),

                            //        List<int> prices = [];
                            // int finalTotal = 0;

                            // for (var prod in state.cartItems) {
                            //   prices.add(prod.price * prod.quantity);
                            // }
                            // print("___________________________");

                            // for (var total in prices) {
                            //   finalTotal = finalTotal + total;
                            //   print(finalTotal);
                            // }

                            (finalTotal != 0)
                                ? SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const MyText(
                                            title: "Order Info",
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                        SizedBox(
                                          height: height(5),
                                        ),
                                        CartTotalComponent(
                                            title: "Subtotal",
                                            cost:
                                                "Rs " + finalTotal.toString()),
                                        SizedBox(
                                          height: height(5),
                                        ),
                                        CartTotalComponent(
                                            title: "Shipping Cost",
                                            cost: (finalTotal * 15 / 100)
                                                .toString()),
                                        SizedBox(
                                          height: height(10),
                                        ),
                                        CartTotalComponent(
                                            title: "Total",
                                            cost: "Rs " +
                                                (finalTotal * 25 / 100 +
                                                        finalTotal)
                                                    .toString()),
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        );
                      }
                    }

                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: MyText(
                              title: "No Products In The Cart", fontSize: 14),
                        ),
                      ],
                    );
                  },
                ),

                // SizedBox(
                //   height: height(10),
                // ),

                // Delivery Address & Payment Method Column

                // Column(
                //   children: [
                //     CartAddressComponent(
                //       leading: Container(
                //           // color: CustomStyles.lightGreyText,
                //           // padding: const EdgeInsets.all(10),
                //           height: height(50),
                //           width: width(50),
                //           child: Stack(
                //             alignment: Alignment.center,
                //             children: [
                //               Image.asset(
                //                 "./assets/images/card_address/map.png",
                //                 // height: height(50),
                //                 // fit: BoxFit.cover,
                //               ),
                //               Positioned(
                //                   child: Container(
                //                 height: height(20),
                //                 width: width(20),
                //                 decoration: BoxDecoration(
                //                     color: Color(0xffFF7043),
                //                     borderRadius: BorderRadius.circular(15)),
                //                 child: Image.asset(
                //                   "./assets/images/card_address/Location.png",
                //                 ),
                //               ))
                //             ],
                //           )),
                //       heading: "Delivery Address",
                //       title: "Chhatak, Sunamgonj 12/8AB",
                //       subTitle: "Sylhet",
                //       trailing: Container(
                //           height: height(25),
                //           width: width(25),
                //           decoration: BoxDecoration(
                //               color: CustomStyles.checkBack,
                //               borderRadius: BorderRadius.circular(15)),
                //           child: const Icon(Icons.check)),
                //     ),
                //     SizedBox(
                //       height: height(10),
                //     ),
                //     CartAddressComponent(
                //       leading: Container(
                //         // color: CustomStyles.lightGreyText,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(15),
                //             color: Color(0xffF5F6FA)),
                //         padding: const EdgeInsets.all(10),
                //         height: height(50),
                //         width: width(50),
                //         child: Image.asset(
                //           "./assets/images/card_address/visa.png",
                //           // height: height(50),
                //           // fit: BoxFit.cover,
                //         ),
                //       ),
                //       heading: "Payment Method",
                //       title: "Visa Classic",
                //       subTitle: "**** 7690",
                //       trailing: Container(
                //           height: height(25),
                //           width: width(25),
                //           decoration: BoxDecoration(
                //               color: CustomStyles.checkBack,
                //               borderRadius: BorderRadius.circular(15)),
                //           child: const Icon(Icons.check)),
                //     ),
                //   ],
                // ),

                SizedBox(
                  height: height(15),
                ),

                // Order Info Column

                // BlocBuilder<CartStreamBloc, CartStreamState>(
                //   builder: (context, state) {
                //     if (state is CartStreamLoaded) {
                //       List<int> prices = [];
                //       int finalTotal = 0;

                //       for (var prod in state.cartItems) {
                //         prices.add(prod.price * prod.quantity);
                //       }
                //       print("___________________________");

                //       for (var total in prices) {
                //         finalTotal = finalTotal + total;
                //         print(finalTotal);
                //       }

                //       if (finalTotal != 0) {
                //         return SizedBox(
                //           width: double.infinity,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const MyText(
                //                   title: "Order Info",
                //                   fontSize: 17,
                //                   fontWeight: FontWeight.w600),
                //               SizedBox(
                //                 height: height(5),
                //               ),
                //               CartTotalComponent(
                //                   title: "Subtotal",
                //                   cost: "Rs " + finalTotal.toString()),
                //               SizedBox(
                //                 height: height(5),
                //               ),
                //               const CartTotalComponent(
                //                   title: "Shipping Cost", cost: "\$10"),
                //               SizedBox(
                //                 height: height(10),
                //               ),
                //               CartTotalComponent(
                //                   title: "Total",
                //                   cost: "Rs " + finalTotal.toString()),
                //             ],
                //           ),
                //         );
                //       }
                //     }
                //     return SizedBox();
                //   },
                // )

                // SizedBox(
                //   width: double.infinity,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const MyText(
                //           title: "Order Info",
                //           fontSize: 17,
                //           fontWeight: FontWeight.w600),
                //       SizedBox(
                //         height: height(5),
                //       ),
                //       const CartTotalComponent(
                //           title: "Subtotal", cost: "\$110"),
                //       SizedBox(
                //         height: height(5),
                //       ),
                //       const CartTotalComponent(
                //           title: "Shipping Cost", cost: "\$10"),
                //       SizedBox(
                //         height: height(10),
                //       ),
                //       const CartTotalComponent(title: "Total", cost: "\$120"),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: CustomStyles.submit,
        child: InkWell(
          splashColor: CustomStyles.submit,
          onTap: () {
            print("Checkout");
            // navigatorKey.currentState?.pushNamed(RouteNames.cart);
          },
          child: Container(
            width: double.infinity,
            height: height(60),
            child: Center(
                child: MyText(
              title: "Checkout",
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
