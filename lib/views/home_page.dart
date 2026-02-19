import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/components/brand_component.dart';
import 'package:ecom_app/components/custom_row_title.dart';
import 'package:ecom_app/components/loding_widget.dart';
// import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/product_card.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:ecom_app/models/wishlist_product_model/wishlist_product_model.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/demo-products.dart';
import 'package:ecom_app/view-models/auth_bloc/auth.dart';
import 'package:ecom_app/view-models/product_detail_bloc/prod_details.dart';
import 'package:ecom_app/view-models/products_bloc/get_products.dart';
import 'package:ecom_app/view-models/wish_list_bloc/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/size_config.dart';
import '../utils/demo-brands.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomePage({super.key, required this.scaffoldKey});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<int> wishlistedIndices = {};
  List wishListIds = [];

  // list of brands
  List<Widget> brandItems = DemoBrands.brandDetails.map((elem) {
    return GestureDetector(
        onTap: () {
          print(elem['title']);
        },
        child: BrandComponent(imagePath: elem['image'], title: elem['title']));
  }).toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // call the event to fetch all the products
    context.read<ProductsBloc>().add(GetAllProductsEvent());
    context.read<WishListBloc>().add(GetAllWishListIds());
  }

  @override
  Widget build(BuildContext context) {
    // List of all products which are displayed in the homepage.
    // List<Widget> newProds =
    //     DemoProducts.productDetails.asMap().entries.map((entry) {
    //   int index = entry.key;
    //   var prod = entry.value;

    //   return ProductCard(
    //     onCardTap: () {
    //       navigatorKey.currentState?.pushNamed(RouteNames.productDetails);
    //     },
    //     imagePath: prod['image'],
    //     title: prod['title'],
    //     price: prod['price'],
    //     isWishlisted: wishlistedIndices.contains(index),
    //     onWishlistToggle: () {
    //       setState(() {
    //         if (wishlistedIndices.contains(index)) {
    //           wishlistedIndices.remove(index);
    //         } else {
    //           wishlistedIndices.add(index);
    //         }
    //       });
    //     },
    //   );
    // }).toList();
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            print(state);
            if (state is AuthLoadingState) {
              loadingWidget(context);
            }
          },
        ),
        BlocListener<WishListBloc, WishListState>(
          listener: (context, state) {
            if (state.isWishListing == true) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Upadating the Wishlist"),
                duration: Duration(seconds: 3),
                showCloseIcon: true,
              ));
            } else if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error!),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
                showCloseIcon: true,
              ));
            }
          },
        )
        // BlocListener<WishListBloc, WishListState>(
        //   listenWhen: (previous, current) =>
        //       previous.isWishListing && !current.isWishListing,
        //   listener: (context, state) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text("Wishlist updated"),
        //         duration: Duration(seconds: 2),
        //       ),
        //     );
        //   },
        // )
      ],
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SafeArea(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          widget.scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Image.asset(
                          "./assets/images/appbar_assets/Menu.png",
                          height: height(45),
                          width: width(45),
                        )),
                    IconButton(
                        onPressed: () {
                          navigatorKey.currentState?.pushNamed(RouteNames.cart);
                        },
                        icon: Image.asset(
                          "./assets/images/appbar_assets/Cart.png",
                          height: height(45),
                          width: width(45),
                        )),
                  ],
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: width(15), right: width(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // welcome msg hello user
                SizedBox(
                  height: height(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                              fontSize: height(28),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter"),
                        ),
                        Text(
                          "Welcome to MyCom",
                          style: TextStyle(
                              fontSize: height(15),
                              fontWeight: FontWeight.normal,
                              color: Color(0xff8F959E),
                              fontFamily: "Inter"),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height(10),
                ),
                //Search Box
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height(50),
                      width: width(275),
                      decoration: BoxDecoration(
                          color: Color(0xffF5F6FA),
                          borderRadius: BorderRadius.circular(width(15))),
                      alignment: Alignment.center,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Color(0xff8F959E)),
                          prefixIcon: Icon(Icons.search),
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: height(14)),
                        ),
                      ),
                    ),
                    Image.asset(
                      "./assets/images/Voice.png",
                      height: height(50),
                      width: width(50),
                    )
                  ],
                ),

                //Choose the Brands
                SizedBox(
                  height: height(15),
                ),
                CustomRowTitle(title: "Choose Brand", subTitle: "View All"),

                // brands
                SizedBox(
                  height: height(10),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: brandItems,
                  ),
                ),

                // New Arrival
                SizedBox(
                  height: height(15),
                ),

                // title
                CustomRowTitle(title: "New Arrival", subTitle: "View All"),

                SizedBox(
                  height: height(10),
                ),

                // display products

                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    final wishState = context.watch<WishListBloc>().state;

                    if (state is ProductsStateSuccess) {
                      // print(state.products['prouctTitle']);

                      final products = state.products;

                      wishListIds =
                          wishState.product.map((e) => e.productId).toList();

                      if (products is QuerySnapshot) {
                        final productWidgets = products.docs.map((doc) {
                          final model = ProductModel.fromFirestore(doc);

                          return ProductCard(
                            onCardTap: () {
                              navigatorKey.currentState?.pushNamed(
                                  RouteNames.productDetails,
                                  arguments: {
                                    "product_id": model.id,
                                    "selectedButton": "S"
                                  });
                            },
                            imagePath: model.img1, // handle Base64 or URL
                            title: model.productTitle,
                            price: "₹ " + model.price.toString(),
                            isWishlisted: wishListIds.contains(model.id),
                            onWishlistToggle: () {
                              context.read<WishListBloc>().add(AddToWishList(
                                  banner_image: model.img1,
                                  title: model.productTitle,
                                  price: model.price,
                                  productId: model.id));
                            },
                          );
                        }).toList();

                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: width(5)),
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: productWidgets,
                          ),
                        );
                      }
                    }
                    return SizedBox();
                  },
                ),
                // BlocListener<WishListBloc, WishListState>(
                //   listener: (context, state) {
                //     if (state.isWishListing) {

                //     }
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
