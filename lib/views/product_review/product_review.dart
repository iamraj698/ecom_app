import 'package:ecom_app/components/alert_widget.dart';
import 'package:ecom_app/components/loding_widget.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/product_text_field.dart';
import 'package:ecom_app/components/rating_star.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/review_model/review_model.dart';
import 'package:ecom_app/utils/app_constants.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/product_review_bloc/product_review.dart';
import 'package:ecom_app/view-models/fetch_all_reviews/fetch_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductReview extends StatefulWidget {
  const ProductReview({super.key});

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {
  final int maxRating = 5;
  late final productId;
  int selectedIndex = 0;
  bool isInit = false;
  TextEditingController reviewController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isInit == false) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      productId = args["productId"];
      isInit = true;
    }

    if (productId != null) {
      // fetch all the review
      print("didchnage deo________________________");
      context
          .read<FetchAllReviewBloc>()
          .add(FetchAllReviewEvent(productId: productId));
    }

    // print("printing the product Id from the review page ${productId}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductReviewBloc, ProductReviewState>(
      listener: (context, state) {
        print(state);
        if (state is ProductReviewLoading) {
          loadingWidget(context);
        } else if (state is ProductReviewError) {
          navigatorKey.currentState?.pop();
          alertWidget(context, state.error);
        } else if (state is ProductReviewSuccess) {
          navigatorKey.currentState?.pop();
          setState(() {
            selectedIndex = 0;
            reviewController.clear();
          });
        } else if (state is ProductDeleteReviewSuccess) {
          navigatorKey.currentState?.pop();
        } else if (state is LatestReviewFetched ||
            state is LatestReviewFetchedZero) {
          navigatorKey.currentState?.pop();
        }
      },
      child: Scaffold(
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
                        if (AppConstants.userDetails == {} ||
                            AppConstants.userDetails['userName'] == null ||
                            AppConstants.userDetails['userName'] == "") {
                          alertWidget(context,
                              "Please Complete Your Profile To Write a Review",
                              textColor: CustomStyles.danger,
                              title: "Complete Profile");
                        } else if (reviewController.text.toString() == "" ||
                            selectedIndex.toString() == "0") {
                          print(
                              reviewController.text + selectedIndex.toString());
                          alertWidget(context,
                              "Please Write Something and Provide a Rating Between 1 to 5 star",
                              title: "Fields Cannot Be Empty");
                        } else {
                          context.read<ProductReviewBloc>().add(AddReview(
                              productId: productId,
                              review: reviewController.text.toString(),
                              timeStamp: DateTime.now().toString(),
                              rating: selectedIndex.toString()));
                        }
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

                BlocBuilder<FetchAllReviewBloc, FetchReviewState>(
                  builder: (context, state) {
                    print(state);
                    if (state is FetchReviewLoading) {
                      loadingWidget(context);
                    } else if (state is FetchReviewLoaded) {
                      List<ReviewModel> reviews = state.reviews;
                      return Column(
                        children: reviews.map((rev) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                            title: rev.userName,
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
                                                color:
                                                    CustomStyles.lightGreyText,
                                              ),
                                              SizedBox(
                                                width: width(4),
                                              ),
                                              MyText(
                                                title: DateFormat("dd-MM-yyy")
                                                    .format(DateTime.parse(
                                                        rev.addedOn)),
                                                fontSize: 11,
                                                color:
                                                    CustomStyles.lightGreyText,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //      MyText(
                                      //       title: rev.rating,
                                      //       fontSize: 15,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //     SizedBox(
                                      //       width: width(3),
                                      //     ),
                                      //     MyText(
                                      //       title: "rating",
                                      //       fontSize: 13,
                                      //       color: CustomStyles.lightGreyText,
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: height(2),
                                      // ),
                                      Row(
                                        children: List.generate(5, (index) {
                                          return RatingStar(
                                            color: index < int.parse(rev.rating)
                                                ? Colors.amber
                                                : CustomStyles.lightGreyText,
                                          );
                                        }),
                                      ),
                                      SizedBox(
                                        height: height(5),
                                      ),
                                      (rev.userId == AppConstants.user!.uid)
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            ProductReviewBloc>()
                                                        .add(DeleteReview(
                                                            reviewId: rev.id,
                                                            productID:
                                                                productId));
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: height(17),
                                                    color: CustomStyles.danger,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                      // Row(
                                      //   children: [
                                      //     RatingStar(),
                                      //     RatingStar(),
                                      //     RatingStar(),
                                      //     RatingStar(),
                                      //     RatingStar(
                                      //       color: CustomStyles.lightGreyText,
                                      //     ),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height(8),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       rev.review,
                              //       style: TextStyle(
                              //         color: CustomStyles.lightGreyText,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      rev.review,
                                      style: TextStyle(
                                        color: CustomStyles.lightGreyText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: height(30),
                              )
                            ],
                          );
                        }).toList(),
                      );
                    } else if (state is FetchReviewError) {
                      MyText(
                        title: state.error,
                        fontSize: 17,
                        color: Colors.red,
                      );
                    }
                    return SizedBox();
                  },
                ),

                // Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Row(
                //           children: [
                //             SizedBox(
                //                 height: height(40),
                //                 width: width(40),
                //                 child: Image.asset(
                //                     "./assets/images/prod_details/reviewer.png")),
                //             SizedBox(
                //               width: width(7),
                //             ),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 const MyText(
                //                   title: "Ronald Richards",
                //                   fontSize: 15,
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //                 SizedBox(
                //                   height: height(2),
                //                 ),
                //                 Row(
                //                   children: [
                //                     Icon(
                //                       Icons.access_time,
                //                       color: CustomStyles.lightGreyText,
                //                     ),
                //                     SizedBox(
                //                       width: width(4),
                //                     ),
                //                     MyText(
                //                       title: "13 Sep, 2020",
                //                       fontSize: 11,
                //                       color: CustomStyles.lightGreyText,
                //                     )
                //                   ],
                //                 )
                //               ],
                //             ),
                //           ],
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Row(
                //               children: [
                //                 const MyText(
                //                   title: "4.8",
                //                   fontSize: 15,
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //                 SizedBox(
                //                   width: width(3),
                //                 ),
                //                 MyText(
                //                   title: "rating",
                //                   fontSize: 13,
                //                   color: CustomStyles.lightGreyText,
                //                 )
                //               ],
                //             ),
                //             SizedBox(
                //               height: height(2),
                //             ),
                //             Row(
                //               children: [
                //                 RatingStar(),
                //                 RatingStar(),
                //                 RatingStar(),
                //                 RatingStar(),
                //                 RatingStar(
                //                   color: CustomStyles.lightGreyText,
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       height: height(8),
                //     ),
                //     MyText(
                //       title:
                //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
                //       fontSize: 15,
                //       color: CustomStyles.lightGreyText,
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
