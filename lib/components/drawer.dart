import 'package:ecom_app/components/custom_list_tile.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/auth_bloc/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatefulWidget {
  final void Function(int)? onItemTapped;
  const MyDrawer({super.key, this.onItemTapped});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // bool isDarkMode = false;

  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, side: BorderSide.none),
        child: ListView(
          children: [
            Container(
              height: height(60),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: width(16)),
              child: InkWell(
                onTap: () {
                  navigatorKey.currentState?.pop();
                },
                child: Transform.rotate(
                  angle: 1.57,
                  child: Image.asset(
                    "./assets/images/appbar_assets/Menu.png",
                    height: height(38),
                    width: width(38),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                "./assets/images/profile_pic.png",
                height: height(43),
                width: width(43),
              ),
              title: const MyText(
                title: "Rajesab",
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              subtitle: Row(
                children: [
                  const MyText(title: "Verified Profile", fontSize: 11),
                  SizedBox(
                    width: width(4),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(width(15))),
                      child: Icon(
                        Icons.check,
                        size: width(13),
                      ))
                ],
              ),
              trailing: Container(
                padding: EdgeInsets.all(width(4)),
                decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(width(15))),
                width: width(66),
                height: height(32),
                child: const Center(
                  child: MyText(
                    title: "3 Orders",
                    fontSize: 11,
                    color: Color(0xff8F959E),
                  ),
                ),
              ),
            ),

            //

            CustomListTile(
              icon: Icons.wb_sunny_outlined,
              title: "Dark Mode",
              trailing: ToggleButtons(
                renderBorder: false,
                splashColor: Colors.transparent,
                borderColor: Colors.transparent,
                fillColor: Colors.transparent,
                isSelected: [isDarkMode],
                onPressed: (int index) {
                  setState(() {
                    isDarkMode = !isDarkMode;
                    // toggle disabled
                    // isDarkMode = isDarkMode;
                  });
                },
                children: [
                  Icon(isDarkMode ? Icons.toggle_off : Icons.toggle_on,
                      size: width(50),
                      color: isDarkMode ? Color(0xffD6D6D6) : Colors.black),
                ],
              ),
            ),

            InkWell(
              onTap: () {
                print("Account Info");
              },
              child: CustomListTile(
                  icon: Icons.info_outline, title: "Account Information"),
            ),
            InkWell(
                onTap: () {
                  print("Password");
                },
                child: CustomListTile(
                    icon: Icons.lock_outline, title: "Password")),
            InkWell(
                onTap: () {
                  print("Order");
                },
                child: CustomListTile(
                    icon: Icons.shopping_bag_outlined, title: "Order")),
            InkWell(
                onTap: () {
                  print("Cards");
                },
                child: CustomListTile(
                    icon: Icons.wallet_outlined, title: "Cards")),
            InkWell(
                onTap: () {
                  print("Wishlist");
                  widget.onItemTapped!(1);
                  navigatorKey.currentState?.pop();
                },
                child: CustomListTile(
                    icon: Icons.favorite_outline, title: "Wishlist")),
            InkWell(
                onTap: () {
                  print("Settings");
                },
                child: CustomListTile(
                    icon: Icons.settings_outlined, title: "Settings")),

            SizedBox(
              height: height(100),
            ),

            InkWell(
              onTap: () {
                // navigatorKey.currentState
                //     ?.pushReplacementNamed(RouteNames.login);
                context.read<AuthBloc>().add(SignOutEvent());
              },
              child: CustomListTile(
                icon: Icons.logout,
                title: "Logout",
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
