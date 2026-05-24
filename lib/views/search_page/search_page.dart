import 'package:ecom_app/components/alert_widget.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/product_card.dart';
import 'package:ecom_app/components/searchbox.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/search_bloc/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchStateSuccess) {
          navigatorKey.currentState
              ?.pushNamed(RouteNames.searchResults, arguments: state.products);
        } else if (state is SearchSuccessEmptyData) {
          navigatorKey.currentState
              ?.pushNamed(RouteNames.searchResults, arguments: []);
        } else if (state is SearchProductsFetchErrorState) {
          navigatorKey.currentState
              ?.pushNamed(RouteNames.searchResults, arguments: state.error);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: height(50),
                child: SearchBox(
                  searchController: searchController,
                ),
              ),
              // Row(
              //   children: [
              //     SizedBox(
              //       height: height(50),
              //       width: width(370),
              //       child: SearchBox(),
              //     )
              //   ],
              // ),
              SizedBox(
                height: height(10),
              ),
              ElevatedButton(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    // proceede to search
                    context.read<SearchBloc>().add(SearchProduct(
                        productName: searchController.text.toString()));
                  } else {
                    alertWidget(context, "Enter something to search");
                  }
                },
                child: MyText(
                  title: "Search",
                  fontSize: 14,
                  color: CustomStyles.textWhite,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomStyles.submit),
              ),

              SizedBox(
                height: height(300),
              ),

              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchStateLoading) {
                    return CircularProgressIndicator();
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
