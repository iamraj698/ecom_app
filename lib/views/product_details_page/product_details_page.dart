import 'package:ecom_app/components/custom_row_title.dart';
import 'package:ecom_app/components/custom_size_btn.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/rating_star.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String banner_image = "banner_image.png";
  @override
  Widget build(BuildContext context) {
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
              )),
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
                child: Image.asset(
                  "assets/images/prod_details/${banner_image}",
                  height: height(350),
                  // fit: BoxFit.cover,
                ),
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
                        title: "Men's Printed Pullover Hoodie",
                        fontSize: 13,
                        color: CustomStyles.lightGreyText,
                      ),
                      MyText(
                        title: "Nike Club Fleece",
                        fontSize: 22,
                        color: CustomStyles.textBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: "Price",
                        fontSize: 13,
                        color: CustomStyles.lightGreyText,
                      ),
                      const MyText(
                        title: "\$120",
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
                          banner_image = "banner_image.png";
                        });
                      },
                      child: SizedBox(
                          height: height(77),
                          width: width(77),
                          child: Image.asset(
                            "assets/images/prod_details/banner_image.png",
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          banner_image = "image_1.png";
                        });
                      },
                      child: InkWell(
                        child: SizedBox(
                            height: height(77),
                            width: width(77),
                            child: Image.asset(
                              "assets/images/prod_details/image_1.png",
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          banner_image = "image_2.png";
                        });
                      },
                      child: SizedBox(
                          height: height(77),
                          width: width(77),
                          child: Image.asset(
                            "assets/images/prod_details/image_2.png",
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          banner_image = "image_3.png";
                        });
                      },
                      child: SizedBox(
                          height: height(77),
                          width: width(77),
                          child: Image.asset(
                            "assets/images/prod_details/image_3.png",
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          banner_image = "image_4.png";
                        });
                      },
                      child: SizedBox(
                          height: height(77),
                          width: width(77),
                          child: Image.asset(
                            "assets/images/prod_details/image_4.png",
                          )),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSizeBtn(title: "S"),
                  CustomSizeBtn(title: "M"),
                  CustomSizeBtn(title: "L"),
                  CustomSizeBtn(title: "XL"),
                  CustomSizeBtn(title: "2Xl"),
                ],
              ),

              SizedBox(
                height: height(15),
              ),
              // description

              Column(
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
                    title:
                        "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with ",
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
                  CustomRowTitle(title: "Review", subTitle: "View All"),
                  SizedBox(
                    height: height(13),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MyText(
                                title: "Ronald Richards",
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
                                    color: CustomStyles.lightGreyText,
                                  ),
                                  SizedBox(
                                    width: width(4),
                                  ),
                                  MyText(
                                    title: "13 Sep, 2020",
                                    fontSize: 11,
                                    color: CustomStyles.lightGreyText,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const MyText(
                                title: "4.8",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                width: width(3),
                              ),
                              MyText(
                                title: "rating",
                                fontSize: 13,
                                color: CustomStyles.lightGreyText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: height(2),
                          ),
                          Row(
                            children: [
                              RatingStar(),
                              RatingStar(),
                              RatingStar(),
                              RatingStar(),
                              RatingStar(
                                color: CustomStyles.lightGreyText,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(8),
                  ),
                  MyText(
                    title:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
                    fontSize: 15,
                    color: CustomStyles.lightGreyText,
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
                    title: "\$125",
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
      bottomNavigationBar: Material(
        color: CustomStyles.submit,
        child: InkWell(
          splashColor: CustomStyles.submit,
          onTap: () {
            print("add to cart");
            navigatorKey.currentState?.pushNamed(RouteNames.cart);
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
      ),
    );
  }
}
