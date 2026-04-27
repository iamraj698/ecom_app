import 'package:ecom_app/components/custom_row_title.dart';
import 'package:ecom_app/components/drawer.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/submit.dart';
import 'package:ecom_app/data/repositories/orders_repository.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/order_models/order_model.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/orders_bloc/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late final args;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as OrderModel;
    print(args.address.name);
    print(args.orderList[0].productName);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrdersCancelledState) {
              navigatorKey.currentState?.pop();
            }
          },
        )
      ],
      child: Scaffold(
          appBar: AppBar(
            title: const MyText(
              title: "Order Details",
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(width(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: args.orderList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    title: "Product Name ",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      title: args.orderList[index].productName,
                                      fontSize: 14),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height(10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    title: "Price",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      title: args.orderList[index].price
                                              .toString() +
                                          " Rs",
                                      fontSize: 14),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height(10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    title: "Quantity ",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      title: args.orderList[index].quantity
                                          .toString(),
                                      fontSize: 14),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height(10),
                          ),
                        ],
                      );
                    },
                  ),

                  // final total

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "Final Total ",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: args.finalTotal.toString() + " Rs",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "Payment Method ",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title: args.paymentType, fontSize: 14),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: height(10),
                  // )

                  SizedBox(
                    height: height(10),
                  ),
                  (args.upiId != "")
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  title: "Upi Id ",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(title: args.upiId, fontSize: 14),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                  // SizedBox(
                  //   height: height(10),
                  // )

                  SizedBox(
                    height: height(20),
                  ),

                  // adddress component
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomRowTitle(
                        title: "Address",
                        subTitle: "",
                      ),
                      Row(
                        children: [
                          const MyText(
                            title: "Customer Name: ",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          MyText(title: args.address.name, fontSize: 14)
                        ],
                      ),
                      Row(
                        children: [
                          const MyText(
                            title: "Phone: ",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          MyText(
                              title: args.address.phone.toString(),
                              fontSize: 14)
                        ],
                      ),
                      Row(
                        children: [
                          const MyText(
                            title: "Area: ",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          MyText(title: args.address.area, fontSize: 14)
                        ],
                      ),
                      Row(
                        children: [
                          const MyText(
                            title: "City: ",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          MyText(title: args.address.city, fontSize: 14)
                        ],
                      ),
                      Row(
                        children: [
                          const MyText(
                            title: "State: ",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          MyText(title: args.address.state, fontSize: 14)
                        ],
                      ),
                      Row(
                        children: [
                          const MyText(
                            title: "Country: ",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          MyText(title: args.address.country, fontSize: 14)
                        ],
                      ),
                      Row(
                        children: [
                          const MyText(
                            title: "Pincode: ",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          MyText(
                              title: args.address.pincode.toString(),
                              fontSize: 14)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Submit(
                submitText: "Cancel Order",
                onTap: () {
                  print("____");
                  context.read<OrderBloc>().add(CancelOrder(
                      orderId: args.orderId, orderItems: args.orderList));
                },
              );
            },
          )),
    );
  }
}
