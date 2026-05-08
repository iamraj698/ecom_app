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
    return Scaffold(
      body: isProductModel
          ? (productModel.isNotEmpty)
              ? SafeArea(
                child: GridView.builder(
                    padding:  EdgeInsets.all(width(20)),
                    itemCount: productModel.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final product = productModel[index];
                
                      return ProductCard(
                        imagePath: product!.img1,
                        title: product.productTitle,
                        price: "₹ ${product.price} ",
                        isWishlisted: true,
                        onWishlistToggle: () {
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
              : Center(child: MyText(title: "No result found", fontSize: 14))
          : Center(
              child: Text(errorMessage.isEmpty ? "Error" : errorMessage),
            ),
    );
  }
}
