// import 'package:ecom_app/models/product_model/product_model.dart';
// import 'package:flutter/material.dart';

// class SearchResults extends StatefulWidget {
//   const SearchResults({super.key});

//   @override
//   State<SearchResults> createState() => _SearchResultsState();
// }

// class _SearchResultsState extends State<SearchResults> {
//   late var settings;
//   List<ProductModel?> productModel = [];
//   bool isProductModel = false;
//   String errorMessage = "";
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();

//     settings = ModalRoute.of(context)!.settings.arguments;
//     if (settings is List<ProductModel?>) {
//       productModel = settings;
//       isProductModel = true;
//     } else if (settings is String) {
//       errorMessage = settings;
//       isProductModel = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [(isProductModel == true) ? Text("products") : Text("error")],
//       ),
//     );
//   }
// }

import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/product_card.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/wish_list_bloc/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late dynamic settings;

  List<ProductModel?> productModel = [];
  bool isProductModel = false;
  String errorMessage = "";

  Set<int> wishlistedIndices = {};
  List wishListIds = [];
  bool addToWishlist = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WishListBloc>().add(GetAllWishListIds());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    settings = ModalRoute.of(context)?.settings.arguments;

    print("__________________________");
    print(settings.runtimeType);

    if (settings is List<ProductModel?>) {
      productModel = settings;
      isProductModel = true;
      print("product_______________________________");
    } else if (settings is List<dynamic>) {
      productModel = [];
      isProductModel = true;
      print("product_______________________________");
    } else if (settings is String) {
      errorMessage = settings; // fixed
      isProductModel = false;
      print("error_________________________________");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishListBloc, WishListState>(
      listenWhen: (previous, current) {
        return previous.isWishListing != current.isWishListing;
      },
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent != true) return;
        if (state.isWishListing == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Updating Wishlist"),
              duration: Duration(seconds: 2),
              showCloseIcon: true,
            ),
          );

          addToWishlist = false;
        } else if (state.isWishListing == false) {
          addToWishlist = true;
        }

        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, wishState) {
        // get all wishlist product ids
        wishListIds = wishState.product.map((e) => e.productId).toList();

        return Scaffold(
          body: isProductModel
              ? (productModel.isNotEmpty)
                  ? SafeArea(
                      child: GridView.builder(
                        padding: EdgeInsets.all(width(20)),
                        itemCount: productModel.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.65,
                        ),
                        itemBuilder: (context, index) {
                          final product = productModel[index]!;

                          return ProductCard(
                            imagePath: product.img1,
                            title: product.productTitle,
                            price: "₹ ${product.price}",

                            // MAIN FIX
                            isWishlisted: wishListIds.contains(product.id),

                            onWishlistToggle: () {
                              if (!addToWishlist) return;

                              context.read<WishListBloc>().add(
                                    AddToWishList(
                                      banner_image: product.img1,
                                      title: product.productTitle,
                                      price: product.price,
                                      productId: product.id,
                                    ),
                                  );
                            },

                            onCardTap: () {
                              navigatorKey.currentState?.pushNamed(
                                RouteNames.productDetails,
                                arguments: {
                                  "product_id": product.id,
                                  "selectedButton": "S",
                                },
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Center(
                      child: MyText(title: "No result found", fontSize: 14),
                    )
              : Center(
                  child: Text(
                    errorMessage.isEmpty ? "Error" : errorMessage,
                  ),
                ),
        );
      },
    );
  }
}
