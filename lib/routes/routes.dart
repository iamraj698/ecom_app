import 'package:ecom_app/components/bottom_navigation.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/views/add_address/add_address.dart';
import 'package:ecom_app/views/auth_pages/login/login_page.dart';
import 'package:ecom_app/views/auth_pages/login_otp/login_otp.dart';
import 'package:ecom_app/views/auth_pages/login_phone/login_phone.dart';
import 'package:ecom_app/views/auth_pages/signup/signup_page.dart';
import 'package:ecom_app/views/cart/cart.dart';
import 'package:ecom_app/views/edit_profile/edit_profile.dart';
import 'package:ecom_app/views/home_page.dart';
import 'package:ecom_app/views/newpage.dart';
import 'package:ecom_app/views/order_details/order_details_page.dart';
import 'package:ecom_app/views/payment_success/payment_success.dart';
import 'package:ecom_app/views/payments_page/payments_page.dart';
import 'package:ecom_app/views/product_details_page/product_details_page.dart';
import 'package:ecom_app/views/product_review/product_review.dart';
import 'package:ecom_app/views/sell_products/sell_products.dart';
import 'package:ecom_app/views/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homepage:
        return MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
          settings: settings,
        );

      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case RouteNames.loginPhone:
        return MaterialPageRoute(
          builder: (context) => const LoginPhone(),
        );

      case RouteNames.loginOtp:
        return MaterialPageRoute(
          builder: (context) => const LoginOtp(),
        );

      case RouteNames.productDetails:
        return MaterialPageRoute(
          builder: (context) => const ProductDetailsPage(),
          settings: settings,
        );

      case RouteNames.cart:
        return MaterialPageRoute(
          builder: (context) => const Cart(),
          settings: settings,
        );

      case RouteNames.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );

      case RouteNames.signUp:
        return MaterialPageRoute(
          builder: (context) => const SignUpPage(),
          settings: settings,
        );

      case RouteNames.sellProducts:
        return MaterialPageRoute(
          builder: (context) => const SellProducts(),
          settings: settings,
        );

      case RouteNames.productReview:
        return MaterialPageRoute(
          builder: (context) => const ProductReview(),
          settings: settings,
        );

      case RouteNames.editProfile:
        return MaterialPageRoute(
          builder: (context) => const EditProfile(),
          settings: settings,
        );
      case RouteNames.addAddress:
        return MaterialPageRoute(
          builder: (context) => const AddAddress(),
          settings: settings,
        );

      case RouteNames.paymentPage:
        return MaterialPageRoute(
          builder: (context) => PaymentsPage(),
          settings: settings,
        );

      case RouteNames.paymentSuccess:
        return MaterialPageRoute(
          builder: (context) => PaymentSuccess(),
          settings: settings,
        );
      case RouteNames.orderDetailPage:
        return MaterialPageRoute(
          builder: (context) => OrderDetailsPage(),
          settings: settings,
        );

      case RouteNames.newpage:
        if (settings.arguments != null) {
          final args = settings.arguments as Map<String, dynamic>;
          String personName = args["personName"];
          return MaterialPageRoute(
              builder: (context) => Newpage(
                    personName: personName,
                  ),
              settings: settings);
        } else {
          return noArgsRoute();
        }

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text("There are no such routes"),
              ),
            );
          },
        );
    }
  }

  static Route<dynamic> noArgsRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text("Null or invalid arguments"),
          ),
        );
      },
    );
  }
}
