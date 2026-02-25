import 'dart:convert';

import 'package:ecom_app/components/bottom_sheet.dart';
import 'package:ecom_app/components/cart_address_component.dart';
import 'package:ecom_app/components/cart_product_card.dart';
import 'package:ecom_app/components/cart_total_component.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/address_model/address_model.dart';
import 'package:ecom_app/models/cart_item_model/cart_item_model.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/address_bloc/address.dart';
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
  List<AddressModel>? listOfaddress = [];
  Map sizeChart = {
    "smQty": "S",
    "mdQty": "M",
    "lgQty": "L",
    "xlQty": "Xl",
  };

  Map selectedAddress = {
    "name": "",
    "phone": "",
    "area": "",
    "state": "",
    "city": "",
    "pincode": "",
    "country": "",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<CartStreamBloc>().add(FetchCartItems());
    context.read<AddressBloc>().add(FetchAllAddresses());
  }

  @override
  Widget build(BuildContext context) {
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
          BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              if (state is AddressFetched) {
                setState(() {
                  listOfaddress = state.address;

                  selectedAddress['name'] =
                      listOfaddress![listOfaddress!.length - 1].name;

                  selectedAddress['area'] =
                      listOfaddress![listOfaddress!.length - 1].area;
                  selectedAddress['city'] =
                      listOfaddress![listOfaddress!.length - 1].city;
                  selectedAddress['state'] =
                      listOfaddress![listOfaddress!.length - 1].state;
                  selectedAddress['country'] =
                      listOfaddress![listOfaddress!.length - 1].country;
                  selectedAddress['phone'] =
                      listOfaddress![listOfaddress!.length - 1]
                          .phone
                          .toString();
                  selectedAddress['pincode'] =
                      listOfaddress![listOfaddress!.length - 1]
                          .pincode
                          .toString();
                });
              }
            },
          )
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
                                BlocBuilder<AddressBloc, AddressState>(
                                  builder: (context, state) {
                                    print(state);
                                    if (state is AddressLoading) {
                                      return CartAddressComponent(
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
                                                      color: const Color(
                                                          0xffFF7043),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Image.asset(
                                                    "./assets/images/card_address/Location.png",
                                                  ),
                                                ))
                                              ],
                                            )),
                                        heading: "Delivery Address",
                                        title: "Lpading....",
                                        subTitle: "Loading...",
                                        trailing: SizedBox(),
                                        onTapSeeAll: () {},
                                      );
                                    } else if (state is AddressFetched) {
                                      // print(
                                      //     "______________________________________");
                                      List<AddressModel>? addresses =
                                          state.address;

                                      return InkWell(
                                          onTap: () {
                                            CustomBottomSheet().bottomSheet(
                                              context,
                                              Column(children: [
                                                (addresses!.isNotEmpty)
                                                    ? Expanded(
                                                        child: ListView.builder(
                                                          itemCount:
                                                              addresses!.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                print(index);
                                                                setState(() {
                                                                  selectedAddress[
                                                                          'name'] =
                                                                      addresses[
                                                                              index]
                                                                          .name;

                                                                  selectedAddress[
                                                                          'area'] =
                                                                      addresses[
                                                                              index]
                                                                          .area;
                                                                  selectedAddress[
                                                                          'city'] =
                                                                      addresses[
                                                                              index]
                                                                          .city;
                                                                  selectedAddress[
                                                                          'state'] =
                                                                      addresses[
                                                                              index]
                                                                          .state;
                                                                  selectedAddress[
                                                                      'country'] = addresses[
                                                                          index]
                                                                      .country;
                                                                  selectedAddress[
                                                                      'phone'] = addresses[
                                                                          index]
                                                                      .phone
                                                                      .toString();
                                                                  selectedAddress[
                                                                      'pincode'] = addresses[
                                                                          index]
                                                                      .pincode
                                                                      .toString();
                                                                });
                                                                navigatorKey
                                                                    .currentState
                                                                    ?.pop();
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .all(width(
                                                                        15)),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              height(30),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width(10),
                                                                        ),
                                                                        MyText(
                                                                          title:
                                                                              addresses[index].name,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .phone,
                                                                          size:
                                                                              height(30),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width(10),
                                                                        ),
                                                                        MyText(
                                                                            title:
                                                                                addresses[index].phone.toString(),
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
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            MyText(
                                                                                title: addresses[index].area,
                                                                                fontSize: 14),
                                                                            MyText(
                                                                                title:
                                                                                    // "Ilkal,Karnataka. 587154.",
                                                                                    addresses[index].city + ", " + addresses[index].state + "." + " " + addresses[index].pincode.toString(),
                                                                                fontSize: 14)
                                                                          ],
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                SizedBox(
                                                  height: height(10),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      print("add address");
                                                      navigatorKey.currentState
                                                          ?.pop();
                                                      navigatorKey.currentState
                                                          ?.pushNamed(RouteNames
                                                              .addAddress);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                CustomStyles
                                                                    .submit),
                                                    child: MyText(
                                                      title: "+ Add Addresss",
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ))
                                              ]),
                                            );
                                          },
                                          child: (addresses!.isNotEmpty)
                                              ? CartAddressComponent(
                                                  onTapSeeAll: () {},
                                                  leading: Container(
                                                      // color: CustomStyles.lightGreyText,
                                                      // padding: const EdgeInsets.all(10),
                                                      height: height(50),
                                                      width: width(50),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
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
                                                                color: const Color(
                                                                    0xffFF7043),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Image.asset(
                                                              "./assets/images/card_address/Location.png",
                                                            ),
                                                          ))
                                                        ],
                                                      )),
                                                  heading: "Delivery Address",
                                                  title: selectedAddress[
                                                          "name"] +
                                                      ", " +
                                                      selectedAddress["area"] +
                                                      ", " +
                                                      selectedAddress["city"] +
                                                      " " +
                                                      selectedAddress["state"] +
                                                      ", " +
                                                      selectedAddress[
                                                          "pincode"],
                                                  subTitle: selectedAddress[
                                                          "city"] +
                                                      ", " +
                                                      selectedAddress["state"],
                                                  trailing: Container(
                                                      height: height(25),
                                                      width: width(25),
                                                      decoration: BoxDecoration(
                                                          color: CustomStyles
                                                              .checkBack,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: const Icon(
                                                          Icons.check)),
                                                )
                                              : CartAddressComponent(
                                                  leading: Container(
                                                      // color: CustomStyles.lightGreyText,
                                                      // padding: const EdgeInsets.all(10),
                                                      height: height(50),
                                                      width: width(50),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
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
                                                                color: const Color(
                                                                    0xffFF7043),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Image.asset(
                                                              "./assets/images/card_address/Location.png",
                                                            ),
                                                          ))
                                                        ],
                                                      )),
                                                  heading: "Delivery Address",
                                                  title:
                                                      "Click Here To Add Address",
                                                  subTitle:
                                                      "Click Here To Add Address",
                                                  trailing: Container(
                                                      height: height(25),
                                                      width: width(25),
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: const Icon(
                                                          Icons.close)),
                                                  onTapSeeAll: () {},
                                                ));
                                    }
                                    return SizedBox();
                                  },
                                ),

                                // payment
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

                            // END builder
                            // Column(
                            //   children: [
                            //     InkWell(
                            //       onTap: () {
                            //         CustomBottomSheet().bottomSheet(
                            //           context,
                            //           Column(
                            //             children: [
                            //               BlocBuilder<AddressBloc,
                            //                   AddressState>(
                            //                 builder: (context, state) {
                            //                   if (state is AddressFetched) {
                            //                     List<AddressModel>? addresses =
                            //                         state.address;

                            //                     if (addresses!.length != 0) {
                            //                       return Expanded(
                            //                         child: ListView.builder(
                            //                           itemCount:
                            //                               addresses!.length,
                            //                           itemBuilder:
                            //                               (context, index) {
                            //                             return InkWell(
                            //                               onTap: () {
                            //                                 print(index);
                            //                                 setState(() {
                            //                                   selectedAddress[
                            //                                           'name'] =
                            //                                       addresses[
                            //                                               index]
                            //                                           .name;

                            //                                   selectedAddress[
                            //                                           'area'] =
                            //                                       addresses[
                            //                                               index]
                            //                                           .area;
                            //                                   selectedAddress[
                            //                                           'city'] =
                            //                                       addresses[
                            //                                               index]
                            //                                           .city;
                            //                                   selectedAddress[
                            //                                           'state'] =
                            //                                       addresses[
                            //                                               index]
                            //                                           .state;
                            //                                   selectedAddress[
                            //                                           'country'] =
                            //                                       addresses[
                            //                                               index]
                            //                                           .country;
                            //                                   selectedAddress[
                            //                                           'phone'] =
                            //                                       addresses[
                            //                                               index]
                            //                                           .phone
                            //                                           .toString();
                            //                                   selectedAddress[
                            //                                           'pincode'] =
                            //                                       addresses[
                            //                                               index]
                            //                                           .pincode
                            //                                           .toString();
                            //                                 });
                            //                                 navigatorKey
                            //                                     .currentState
                            //                                     ?.pop();
                            //                               },
                            //                               child: Padding(
                            //                                 padding:
                            //                                     EdgeInsets.all(
                            //                                         width(15)),
                            //                                 child: Column(
                            //                                   children: [
                            //                                     Row(
                            //                                       children: [
                            //                                         Icon(
                            //                                           Icons
                            //                                               .person,
                            //                                           size: height(
                            //                                               30),
                            //                                         ),
                            //                                         SizedBox(
                            //                                           width:
                            //                                               width(
                            //                                                   10),
                            //                                         ),
                            //                                         MyText(
                            //                                           title: addresses[
                            //                                                   index]
                            //                                               .name,
                            //                                           fontSize:
                            //                                               14,
                            //                                           fontWeight:
                            //                                               FontWeight
                            //                                                   .bold,
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                     Row(
                            //                                       children: [
                            //                                         Icon(
                            //                                           Icons
                            //                                               .phone,
                            //                                           size: height(
                            //                                               30),
                            //                                         ),
                            //                                         SizedBox(
                            //                                           width:
                            //                                               width(
                            //                                                   10),
                            //                                         ),
                            //                                         MyText(
                            //                                             title: addresses[index]
                            //                                                 .phone
                            //                                                 .toString(),
                            //                                             fontSize:
                            //                                                 14)
                            //                                       ],
                            //                                     ),
                            //                                     Row(
                            //                                       children: [
                            //                                         Icon(
                            //                                           Icons
                            //                                               .location_on,
                            //                                           size: height(
                            //                                               30),
                            //                                         ),
                            //                                         SizedBox(
                            //                                           width:
                            //                                               width(
                            //                                                   10),
                            //                                         ),
                            //                                         Column(
                            //                                           crossAxisAlignment:
                            //                                               CrossAxisAlignment
                            //                                                   .start,
                            //                                           children: [
                            //                                             MyText(
                            //                                                 title:
                            //                                                     addresses[index].area,
                            //                                                 fontSize: 14),
                            //                                             MyText(
                            //                                                 title:
                            //                                                     // "Ilkal,Karnataka. 587154.",
                            //                                                     addresses[index].city + ", " + addresses[index].state + "." + " " + addresses[index].pincode.toString(),
                            //                                                 fontSize: 14)
                            //                                           ],
                            //                                         )
                            //                                       ],
                            //                                     )
                            //                                   ],
                            //                                 ),
                            //                               ),
                            //                             );
                            //                           },
                            //                         ),
                            //                       );
                            //                     }
                            //                   }
                            //                   return SizedBox();
                            //                 },
                            //               ),
                            //               SizedBox(
                            //                 height: height(10),
                            //               ),
                            //               ElevatedButton(
                            //                   onPressed: () {
                            //                     print("add address");
                            //                     navigatorKey.currentState
                            //                         ?.pop();
                            //                     navigatorKey.currentState
                            //                         ?.pushNamed(
                            //                             RouteNames.addAddress);
                            //                   },
                            //                   style: ElevatedButton.styleFrom(
                            //                       backgroundColor:
                            //                           CustomStyles.submit),
                            //                   child: MyText(
                            //                     title: "+ Add Addresss",
                            //                     fontSize: 18,
                            //                     color: Colors.white,
                            //                   ))
                            //             ],
                            //           ),
                            //         );
                            //       },
                            //       child: CartAddressComponent(
                            //         onTapSeeAll: () {},
                            //         leading: Container(
                            //             // color: CustomStyles.lightGreyText,
                            //             // padding: const EdgeInsets.all(10),
                            //             height: height(50),
                            //             width: width(50),
                            //             child: Stack(
                            //               alignment: Alignment.center,
                            //               children: [
                            //                 Image.asset(
                            //                   "./assets/images/card_address/map.png",
                            //                   // height: height(50),
                            //                   // fit: BoxFit.cover,
                            //                 ),
                            //                 Positioned(
                            //                     child: Container(
                            //                   height: height(20),
                            //                   width: width(20),
                            //                   decoration: BoxDecoration(
                            //                       color:
                            //                           const Color(0xffFF7043),
                            //                       borderRadius:
                            //                           BorderRadius.circular(
                            //                               15)),
                            //                   child: Image.asset(
                            //                     "./assets/images/card_address/Location.png",
                            //                   ),
                            //                 ))
                            //               ],
                            //             )),
                            //         heading: "Delivery Address",
                            //         title: selectedAddress["name"] +
                            //             ", " +
                            //             selectedAddress["area"] +
                            //             ", " +
                            //             selectedAddress["city"] +
                            //             " " +
                            //             selectedAddress["state"] +
                            //             ", " +
                            //             selectedAddress["pincode"],
                            //         subTitle: selectedAddress["city"] +
                            //             ", " +
                            //             selectedAddress["state"],
                            //         trailing: Container(
                            //             height: height(25),
                            //             width: width(25),
                            //             decoration: BoxDecoration(
                            //                 color: CustomStyles.checkBack,
                            //                 borderRadius:
                            //                     BorderRadius.circular(15)),
                            //             child: const Icon(Icons.check)),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: height(10),
                            //     ),
                            //     CartAddressComponent(
                            //       onTapSeeAll: () {},
                            //       leading: Container(
                            //         // color: CustomStyles.lightGreyText,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(15),
                            //             color: const Color(0xffF5F6FA)),
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
                            //               borderRadius:
                            //                   BorderRadius.circular(15)),
                            //           child: const Icon(Icons.check)),
                            //     ),
                            //   ],
                            // ),

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
                    if (state is CartStreamStateLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
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
                SizedBox(
                  height: height(15),
                ),
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
