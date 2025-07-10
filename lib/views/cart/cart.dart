import 'package:ecom_app/components/cart_address_component.dart';
import 'package:ecom_app/components/cart_product_card.dart';
import 'package:ecom_app/components/cart_total_component.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cart"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width(20)),
          child: Column(
            // parent column
            children: [
              const CartProductCard(),
              SizedBox(
                height: height(10),
              ),
              const CartProductCard(),

              SizedBox(
                height: height(10),
              ),

              // Delivery Address & Payment Method Column

              Column(
                children: [
                  CartAddressComponent(
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
                                  color: Color(0xffFF7043),
                                  borderRadius: BorderRadius.circular(15)),
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
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(Icons.check)),
                  ),
                  SizedBox(
                    height: height(10),
                  ),
                  CartAddressComponent(
                    leading: Container(
                      // color: CustomStyles.lightGreyText,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffF5F6FA)),
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
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(Icons.check)),
                  ),
                ],
              ),

              SizedBox(
                height: height(15),
              ),

              // Order Info Column

              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyText(
                        title: "Order Info",
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      height: height(5),
                    ),
                    const CartTotalComponent(title: "Subtotal", cost: "\$110"),
                    SizedBox(
                      height: height(5),
                    ),
                    const CartTotalComponent(
                        title: "Shipping Cost", cost: "\$10"),
                    SizedBox(
                      height: height(10),
                    ),
                    const CartTotalComponent(title: "Total", cost: "\$120"),
                  ],
                ),
              )
            ],
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
