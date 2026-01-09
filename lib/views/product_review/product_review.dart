import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/product_text_field.dart';
import 'package:ecom_app/components/rating_star.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/product_review_bloc/product_review_bloc.dart';
import 'package:ecom_app/view-models/product_review_bloc/product_review_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductReview extends StatefulWidget {
  const ProductReview({super.key});

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {
  final int maxRating = 5;
  late final productId;
  int selectedIndex = 0;
  TextEditingController reviewController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    productId = args["productId"];
    // print("printing the product Id from the review page ${productId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(title: "Reviews", fontSize: 17),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width(20)),
          child: Column(
            children: [
              // Write a Review
              ProductTextField(
                controller: reviewController,
                title: "Write a Review",
                maxLines: 8,
              ),
              SizedBox(
                height: height(15),
              ),

              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        title: "Kindly give rating",
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),

                  // Rating Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      maxRating,
                      (index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              selectedIndex = index + 1;
                              print(selectedIndex);
                            });
                          },
                          icon: (index < selectedIndex)
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          color: Colors.amber,
                        );
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: height(10),
              ),

              // SUBMIT BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductReviewBloc>().add(AddReview(
                          productId: productId,
                          review: reviewController.text.toString(),
                          timeStamp: DateTime.now().toString(),
                          rating: selectedIndex.toString()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: CustomStyles.submit,
                    ),
                    child: MyText(
                      title: "Post",
                      fontSize: 14,
                      color: CustomStyles.textWhite,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: height(15),
              ),

              // All Reviews
              Column(
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
