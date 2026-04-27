import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/pay_button.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/orders_bloc/orders_bloc.dart';
import 'package:ecom_app/view-models/orders_bloc/orders_event.dart';
import 'package:ecom_app/view-models/orders_bloc/orders_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  TextEditingController upiController = TextEditingController();
  String? dropDownValue = "";
  String selectedMethod = "";
  Map? upiEndPoints = {
    "GooglePay": "@okaxis",
    "Phonepe": "@ybl",
    "AmazonPay": "@apl",
    "Paytm": "@paytm",
    "Cred": "@cred",
    "Other": "",
  };
  bool showCardForm = false;
  bool cashOnDelivery = false;
  bool initArgs = false;
  var paymentType = "";
  late final args;
  TextEditingController cardnumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController validThuController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (initArgs == false) {
      final settings = ModalRoute.of(context)!.settings;
      args = settings.arguments as Map<String, dynamic>;
      print(args);
      print(args["finalTotal"]);
      initArgs = true;
    }
    // final productDetails = args;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            print(state);
            if (state is OrderSuccessState) {
              print("payment Success");
              navigatorKey.currentState?.pushNamed(RouteNames.paymentSuccess);
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const MyText(title: "Payments", fontSize: 24),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width(20)),
            child: Column(
              children: [
                // Upi column
                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          title: "Payment Method",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(20),
                    ),
                    // upi row
                    const Row(
                      children: [
                        MyText(
                          title: "UPI",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: CustomStyles.lightGreyText)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: CustomStyles.lightGreyText))),
                      value: dropDownValue,
                      items: const [
                        DropdownMenuItem(
                            value: "", child: Text("Select Your Upi App")),
                        DropdownMenuItem<String>(
                            value: "GooglePay", child: Text("GooglePay")),
                        DropdownMenuItem<String>(
                            value: "Phonepe", child: Text("Phonepe")),
                        DropdownMenuItem<String>(
                            value: "Paytm", child: Text("Paytm")),
                        DropdownMenuItem<String>(
                            value: "AmazonPay", child: Text("AmazonPay")),
                        DropdownMenuItem<String>(
                            value: "Other", child: Text("Other")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          print(value);
                          if (value!.isEmpty) {
                            print("geerere____________");
                            dropDownValue = "";
                            return;
                          }
                          dropDownValue = value;
                          upiController.text = upiEndPoints![value];
                          showCardForm = false;
                          print(dropDownValue);
                        });
                      },
                    ),

                    (dropDownValue != "")
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height(10),
                              ),
                              const MyText(
                                  title: "Enter Your Upi Id", fontSize: 14),
                              SizedBox(
                                height: height(10),
                              ),
                              TextField(
                                controller: upiController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "8891812122@abc",
                                  // border: UnderlineInputBorder(borderSide: BorderSide(color: CustomStyles.lightGreyText))
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CustomStyles.lightGreyText)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: CustomStyles.lightGreyText,
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: height(10),
                              ),
                              PayButton(
                                  onTap: () {
                                    paymentType = "upi";
                                    print("upi________________");
                                    print(
                                        '${args["finalTotal"]},${args["cartItems"]},${args["selectedAddress"]},${args["shippingCost"]},${DateTime.now()},${upiController.text} ');

                                    context.read<OrderBloc>().add(
                                          PlaceOrder(
                                              finalTotal: args["finalTotal"],
                                              cartItems: args["cartItems"],
                                              address: args["selectedAddress"],
                                              shippingCost:
                                                  args["shippingCost"],
                                              orderedOn: DateTime.now(),
                                              orderType: "upi",
                                              upiId: upiController.text),
                                        );
                                  },
                                  title:
                                      "Continue To Pay ${args["finalTotal"] + args["shippingCost"]} Rs ")
                            ],
                          )
                        : const SizedBox(),
                    // SizedBox(
                    //   height: height(10),
                    // ),
                    // Theme(
                    //   data: Theme.of(context).copyWith(
                    //     dividerColor: Colors.transparent, // removes border line
                    //   ),
                    //   child: ExpansionTile(
                    //     tilePadding: const EdgeInsets.all(0),
                    //     onExpansionChanged: (value) {
                    //       // print(":__________________________________________");
                    //       // print(value);
                    //       setState(() {
                    //         dropDownValue = "";
                    //       });
                    //       // print(dropDownValue);
                    //     },
                    //     title: const Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         MyText(
                    //           title: "Cards",
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ],
                    //     ),
                    //     children: [
                    //       Column(
                    //         children: [
                    //           const Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [
                    //               MyText(title: "Card Number", fontSize: 14),
                    //             ],
                    //           ),
                    //           TextField(
                    //             decoration: InputDecoration(
                    //               // border: UnderlineInputBorder(borderSide: BorderSide(color: CustomStyles.lightGreyText))
                    //               hintText: "XXXX XXXX XXXX XXXX",
                    //               focusedBorder: OutlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                       color: CustomStyles.lightGreyText)),
                    //               border: OutlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                 color: CustomStyles.lightGreyText,
                    //               )),
                    //             ),
                    //           ),

                    //           SizedBox(
                    //             height: height(10),
                    //           ),

                    //           // valid
                    //           Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   const MyText(
                    //                       title: "Valid Thu", fontSize: 14),
                    //                   SizedBox(
                    //                     width:
                    //                         MediaQuery.of(context).size.width *
                    //                             0.4,
                    //                     child: TextField(
                    //                       decoration: InputDecoration(
                    //                         // border: UnderlineInputBorder(borderSide: BorderSide(color: CustomStyles.lightGreyText))
                    //                         hintText: "MM / YY",
                    //                         focusedBorder: OutlineInputBorder(
                    //                             borderSide: BorderSide(
                    //                                 color: CustomStyles
                    //                                     .lightGreyText)),
                    //                         border: OutlineInputBorder(
                    //                             borderSide: BorderSide(
                    //                           color: CustomStyles.lightGreyText,
                    //                         )),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   const MyText(title: "CVV", fontSize: 14),
                    //                   SizedBox(
                    //                     width:
                    //                         MediaQuery.of(context).size.width *
                    //                             0.4,
                    //                     child: TextField(
                    //                       decoration: InputDecoration(
                    //                         // border: UnderlineInputBorder(borderSide: BorderSide(color: CustomStyles.lightGreyText))
                    //                         hintText: "CVV",
                    //                         focusedBorder: OutlineInputBorder(
                    //                             borderSide: BorderSide(
                    //                                 color: CustomStyles
                    //                                     .lightGreyText)),
                    //                         border: OutlineInputBorder(
                    //                             borderSide: BorderSide(
                    //                           color: CustomStyles.lightGreyText,
                    //                         )),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               )
                    //             ],
                    //           ),
                    //           SizedBox(
                    //             height: height(10),
                    //           ),
                    //           PayButton(
                    //             onTap: () {
                    //               // navigatorKey.currentState
                    //               //     ?.pushNamed(RouteNames.paymentSuccess);
                    //               context.read<OrderBloc>().add(
                    //                     PlaceOrder(
                    //                         finalTotal: args["finalTotal"],
                    //                         cartItems: args["cartItems"],
                    //                         address: args["address"],
                    //                         shippingCost: args["shippingCost"],
                    //                         orderedOn: DateTime.now(),
                    //                         orderType: "cards",
                    //                         cardNumber: int.parse(
                    //                             cardnumberController.text),
                    //                         cvv: int.parse(cvvController.text),
                    //                         validThu: int.parse(
                    //                             validThuController.text)),
                    //                   );
                    //             },
                    //             title:
                    //                 "Pay ${args["finalTotal"] + args["shippingCost"]} Rs",
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: height(10),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent, // removes border line
                      ),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.all(0),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              title: "Cash On Delivery",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CupertinoButton(
                              child: MyText(
                                title: "Place Order",
                                fontSize: 14,
                                color: CustomStyles.textWhite,
                              ),
                              color: CustomStyles.submit,
                              onPressed: () {
                                context.read<OrderBloc>().add(
                                      PlaceOrder(
                                        finalTotal: args["finalTotal"],
                                        cartItems: args["cartItems"],
                                        address: args["selectedAddress"],
                                        shippingCost: args["shippingCost"],
                                        orderedOn: DateTime.now(),
                                        orderType: "cod",
                                      ),
                                    );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                // End Upi Column

                // cards column
                SizedBox(
                  height: height(10),
                ),

                // Column(
                //   children: [
                //     //
                //     InkWell(
                //       onTap: () {
                //         setState(() {
                //           showCardForm = !showCardForm;
                //           dropDownValue = "";
                //         });
                //       },
                //       child: Container(
                //         // color: CustomStyles.cartImagBack,
                //         height: height(30),
                //         child: const Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Expanded(
                //               child: MyText(
                //                 title: "Cards",
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //             Icon(Icons.arrow_drop_down)
                //           ],
                //         ),
                //       ),
                //     ),
                //     // (showCardForm == true)
                //     //     ? Column(
                //     //         children: [
                //     //           const Row(
                //     //             mainAxisAlignment: MainAxisAlignment.start,
                //     //             children: [
                //     //               MyText(title: "Card Number", fontSize: 14),
                //     //             ],
                //     //           ),
                //     //           TextField(
                //     //             decoration: InputDecoration(
                //     //               // border: UnderlineInputBorder(borderSide: BorderSide(color: CustomStyles.lightGreyText))
                //     //               hintText: "XXXX XXXX XXXX XXXX",
                //     //               focusedBorder: OutlineInputBorder(
                //     //                   borderSide: BorderSide(
                //     //                       color: CustomStyles.lightGreyText)),
                //     //               border: OutlineInputBorder(
                //     //                   borderSide: BorderSide(
                //     //                 color: CustomStyles.lightGreyText,
                //     //               )),
                //     //             ),
                //     //           ),

                //     //           SizedBox(
                //     //             height: height(10),
                //     //           ),

                //     //           // valid
                //     //           Row(
                //     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     //             children: [
                //     //               Column(
                //     //                 crossAxisAlignment: CrossAxisAlignment.start,
                //     //                 children: [
                //     //                   const MyText(
                //     //                       title: "Valid Thu", fontSize: 14),
                //     //                   SizedBox(
                //     //                     width:
                //     //                         MediaQuery.of(context).size.width * 0.4,
                //     //                     child: TextField(
                //     //                       decoration: InputDecoration(
                //     //                         // border: UnderlineInputBorder(borderSide: BorderSide(color: CustomStyles.lightGreyText))
                //     //                         hintText: "MM / YY",
                //     //                         focusedBorder: OutlineInputBorder(
                //     //                             borderSide: BorderSide(
                //     //                                 color: CustomStyles
                //     //                                     .lightGreyText)),
                //     //                         border: OutlineInputBorder(
                //     //                             borderSide: BorderSide(
                //     //                           color: CustomStyles.lightGreyText,
                //     //                         )),
                //     //                       ),
                //     //                     ),
                //     //                   ),
                //     //                 ],
                //     //               ),
                //     //               Column(
                //     //                 crossAxisAlignment: CrossAxisAlignment.start,
                //     //                 children: [
                //     //                   const MyText(title: "CVV", fontSize: 14),
                //     //                   SizedBox(
                //     //                     width:
                //     //                         MediaQuery.of(context).size.width * 0.4,
                //     //                     child: TextField(
                //     //                       decoration: InputDecoration(
                //     //                         // border: UnderlineInputBorder(borderSide: BorderSide(color: CustomStyles.lightGreyText))
                //     //                         hintText: "CVV",
                //     //                         focusedBorder: OutlineInputBorder(
                //     //                             borderSide: BorderSide(
                //     //                                 color: CustomStyles
                //     //                                     .lightGreyText)),
                //     //                         border: OutlineInputBorder(
                //     //                             borderSide: BorderSide(
                //     //                           color: CustomStyles.lightGreyText,
                //     //                         )),
                //     //                       ),
                //     //                     ),
                //     //                   ),
                //     //                 ],
                //     //               )
                //     //             ],
                //     //           ),
                //     //         ],
                //     //       )
                //     //     : const SizedBox(),
                //   ],
                // ),

                //   CartAddressComponent(
                //     onTapSeeAll: () {},
                //     leading: Container(
                //       // color: CustomStyles.lightGreyText,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(15),
                //           color: const Color(0xffF5F6FA)),
                //       padding: const EdgeInsets.all(10),
                //       height: height(50),
                //       width: width(50),
                //       child: Image.asset(
                //         "./assets/images/card_address/visa.png",
                //         // height: height(50),
                //         // fit: BoxFit.cover,
                //       ),
                //     ),
                //     heading: "Cards",
                //     title: "Visa Classic",
                //     subTitle: "**** 7690",
                //     trailing: Container(
                //         height: height(25),
                //         width: width(25),
                //         decoration: BoxDecoration(
                //             color: CustomStyles.checkBack,
                //             borderRadius: BorderRadius.circular(15)),
                //         child: const Icon(Icons.check)),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
