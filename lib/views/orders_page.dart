import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/orders_bloc/orders.dart';
import 'package:ecom_app/view-models/orders_bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatefulWidget {
  final void Function(int)? onItemTapped;
  const OrdersPage({super.key, required this.onItemTapped});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrderBloc>().add(FetchAllOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width(7)),
                  child: Container(
                      decoration: BoxDecoration(
                          color: const Color(
                            0xffF5F6FA,
                          ),
                          borderRadius: BorderRadius.circular(width(30))),
                      height: height(40),
                      width: width(40),
                      child: IconButton(
                          onPressed: () {
                            widget.onItemTapped!.call(0);
                          },
                          icon: const Icon(
                            Icons.home_outlined,
                            size: 27,
                          ))),
                ),
                const MyText(
                  title: "Orders",
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
        child: Padding(
          padding: EdgeInsets.all(
            width(10),
          ),
          child: Column(
            children: [
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is OrdersFetched) {
                    final orders = state.orders;
                    if (orders.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                      RouteNames.orderDetailPage,
                                      arguments: orders[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(width(10)),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(width(15)),
                                    color: CustomStyles.cartImagBack,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                            title:
                                                "${orders[index]!.orderList.length} Products",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(
                                            height: height(5),
                                          ),
                                          MyText(
                                              title:
                                                  "Ordered On: ${DateFormat("dd-mm-yyyy").format(orders[index]!.orderedOn)}",
                                              fontSize: 14)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              const MyText(
                                                title: "Price",
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              SizedBox(
                                                height: height(5),
                                              ),
                                              MyText(
                                                title: orders[index]!
                                                    .finalTotal
                                                    .toString(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height(10),
                              )
                            ],
                          );
                        },
                      );
                    } else if (orders.isEmpty) {
                      return Center(
                        child: MyText(
                          title: "No Orders Placed",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  }
                  return SizedBox();
                },
              )

              // Container(
              //   padding: EdgeInsets.all(width(10)),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(width(15)),
              //     color: CustomStyles.cartImagBack,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const MyText(
              //             title: "3 Products",
              //             fontSize: 14,
              //             fontWeight: FontWeight.bold,
              //           ),
              //           SizedBox(
              //             height: height(5),
              //           ),
              //           const MyText(
              //               title: "Ordered On: 31-02-2024", fontSize: 14)
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Column(
              //             children: [
              //               const MyText(
              //                 title: "Price",
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //               SizedBox(
              //                 height: height(5),
              //               ),
              //               const MyText(
              //                 title: "891 Rs",
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ],
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: height(10),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
