import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/product_card.dart';
import 'package:ecom_app/utils/demo_wish_list.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("wishlist initstate");
    productJson = DemoWishList.productDetails;
    for (var prod in productJson['products']) {
      prodList.add(prod);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> wishListItems = prodList.asMap().entries.map((entry) {
      int index = entry.key;
      var prod = entry.value;

      return ProductCard(
        onCardTap: () {},
        imagePath: prod['image'],
        title: prod['title'],
        price: prod['price'],
        isWishlisted: true,
        onWishlistToggle: () {
          setState(() {
            if (wishlistedIndices.contains(index)) {
              wishlistedIndices.remove(index);
            } else {
              wishlistedIndices.add(index);
            }
          });
        },
      );
    }).toList();
    // List<Widget> wishListItems = prodList.map((prod) {
    //   return ProductCard(
    //       imagePath: prod['image'], title: prod['title'], price: prod['price'] ,
    //       );
    // }).toList();
    return Scaffold(
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
                          title:
                              "${productJson['total-products'].toString()} Items",
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
                padding: EdgeInsets.only(left: width(5), right: width(5)),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: wishListItems,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
