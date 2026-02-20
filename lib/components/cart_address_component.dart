import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CartAddressComponent extends StatelessWidget {
  CartAddressComponent(
      {super.key,
      required this.leading,
      required this.heading,
      required this.title,
      required this.subTitle,
      required this.trailing,
      required this.onTapSeeAll});

  final Widget leading;
  final String title;
  final String heading;
  final String subTitle;
  final Widget trailing;
  VoidCallback onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              title: heading,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            InkWell(
              onTap: onTapSeeAll,
              child: SizedBox(
                height: height(16),
                width: width(16),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: CustomStyles.textBlack,
                  size: width(16),
                ),
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
            // Container(
            //   color: CustomStyles.lightGreyText,
            //   padding: const EdgeInsets.all(10),
            //   height: height(50),
            //   width: width(50),
            //   child: const Icon(
            //     Icons.assistant_navigation,
            //     // size: width(50),
            //   ),
            // ),

            leading,

            Container(
              // color: Colors.red,
              padding: EdgeInsets.only(left: width(15)),
              width: width(250),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: title,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: height(6),
                  ),
                  MyText(
                    title: subTitle,
                    fontSize: 13,
                    color: CustomStyles.lightGreyText,
                  ),
                ],
              ),
            ),
            // Container(
            //     height: height(25),
            //     width: width(25),
            //     decoration: BoxDecoration(
            //         color: CustomStyles.checkBack,
            //         borderRadius: BorderRadius.circular(15)),
            //     child: const Icon(Icons.check))

            trailing,
          ],
        )
      ],
    );
  }
}
