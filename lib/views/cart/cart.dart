import 'package:ecom_app/components/cart_product_card.dart';
import 'package:ecom_app/components/my_text.dart';
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

              // Delivery Address Col

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        title: "Delivery Address",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: height(16),
                        width: width(16),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: CustomStyles.textBlack,
                          size: width(16),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: CustomStyles.lightGreyText,
                        padding: const EdgeInsets.all(10),
                        height: height(50),
                        width: width(50),
                        child: const Icon(
                          Icons.assistant_navigation,
                          // size: width(50),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyText(
                            title: "Chhatak, Sunamgonj 12/8AB",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: height(6),
                          ),
                          MyText(
                            title: "Sylhet",
                            fontSize: 13,
                            color: CustomStyles.lightGreyText,
                          ),
                        ],
                      ),
                      Container(
                          height: height(25),
                          width: width(25),
                          decoration:
                              BoxDecoration(color: CustomStyles.checkBack,borderRadius: BorderRadius.circular(15)),

                          child: const Icon(Icons.check))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
