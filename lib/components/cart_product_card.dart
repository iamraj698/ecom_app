import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CartProductCard extends StatefulWidget {
  CartProductCard(
      {super.key,
      required this.banner_image,
      required this.title,
      required this.price,
      required this.quantity,
      required this.onDelete,
      required this.size,
      required this.onIncrement,
      required this.onDecrement});
  Image banner_image;
  String title;
  String price;
  String quantity;
  VoidCallback onDelete;
  VoidCallback onIncrement;
  VoidCallback onDecrement;
  String size;

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  @override
  Widget build(BuildContext context) {
    return // cart row
        Card(
      color: CustomStyles.textWhite,

      // shape: RoundedRectangleBorder(),
      child: Padding(
        padding: EdgeInsets.all(width(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height(96),
              width: width(77),
              decoration: BoxDecoration(
                  color: CustomStyles.cartImagBack,
                  borderRadius: BorderRadius.circular(width(15))),
              // child: Image.asset(
              //   "./assets/images/prod_details/banner_image.png",
              // ),
              child: widget.banner_image,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width(145),
                  child: Text(
                    // "Men's Tie-Dye T-Shirt Nike Sportswear",
                    widget.title,
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: height(13),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: height(10),
                ),
                MyText(
                  // title: "\$45 (-\$4.00 Tax)",
                  title: "Size " + widget.size,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: CustomStyles.lightGreyText,
                ),
                SizedBox(
                  height: height(10),
                ),
                MyText(
                  // title: "\$45 (-\$4.00 Tax)",
                  title: widget.price,
                  fontSize: 11,
                  color: CustomStyles.lightGreyText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: widget.onIncrement,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomStyles.textWhite,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(width(5)), // reduce size
                          minimumSize:
                              Size(width(36), width(36)), // compact size
                          // elevation: 0, // optional: remove shadow
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: CustomStyles.lightGreyText,
                        )),
                    SizedBox(
                      width: width(5),
                    ),
                    MyText(
                      // title: "1",
                      title: widget.quantity,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: width(5),
                    ),
                    ElevatedButton(
                        onPressed: widget.onDecrement,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomStyles.textWhite,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(width(5)), // reduce size
                          minimumSize:
                              Size(width(36), width(36)), // compact size
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: CustomStyles.lightGreyText,
                        )),
                  ],
                ),
              ],
            ),
            Container(
              height: height(96),
              // color: Colors.red,
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(width(4)),
                decoration: BoxDecoration(
                    // color: CustomStyles.cartImagBack,
                    border: Border.all(
                      color: CustomStyles.cartImagBack,
                    ),
                    borderRadius: BorderRadius.circular(
                      width(50),
                    )),
                child: InkWell(
                  onTap: widget.onDelete,
                  child: Icon(
                    Icons.delete_outline,
                    color: CustomStyles.lightGreyText,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
