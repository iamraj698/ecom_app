// import 'package:ecom_app/components/custom_list_tile.dart';
import 'dart:collection';

import 'package:ecom_app/components/drawer.dart';
// import 'package:ecom_app/components/my_text.dart';
// import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/views/home_page.dart';
import 'package:ecom_app/views/wish_list.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List _tabHistory = [];
  bool canPop = true;

  int _currentIndex = 0;
  List<Widget> get screens => [
        HomePage(scaffoldKey: _scaffoldKey),
        // const Center(child: Text("2nd")),
        WishList(
          onItemTapped: _onTabTapped,
        ),
        const Center(child: Text("3rd")),
        const Center(child: Text("4th")),
      ];

  void _onTabTapped(int index) {
    // if tapping the same tab, do nothing
    if (index == _currentIndex) return;

    // push current index to history, then change to new one
    _tabHistory.add(index);

    // print("the index of this page is ${index}");
    if (index == 0) {
      _tabHistory.clear();
      canPop = true;
    } else {
      canPop = false;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_tabHistory);
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
          Navigator.of(context).pop(); // closes the drawer
          return;
        } else if (_tabHistory.isNotEmpty) {
          setState(() {
            _tabHistory.clear();
            _currentIndex = 0;
          });
          return;
        } else if (_tabHistory.isEmpty) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Tap again to exit"),
              backgroundColor: Colors.black,
            ));
            canPop = true;
          });
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(
          onItemTapped: _onTabTapped,
        ),
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 28,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed, //
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  // color: Colors.black,
                ),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_outlined,
                  // color: Colors.black,
                ),
                label: "Wish List",
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined), label: "Cart"),
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.wallet,
                    // color: Colors.black,
                  ),
                  label: "Cart"),
            ]),
      ),
    );
  }
}
