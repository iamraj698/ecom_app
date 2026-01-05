import 'package:ecom_app/routes/routes.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/auth_bloc/auth.dart';
import 'package:ecom_app/view-models/demo_bloc/demo_bloc.dart';
import 'package:ecom_app/view-models/products_bloc/get_products.dart';
import 'package:ecom_app/view-models/sell_product_bloc/sell_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => DemoBloc()),
    BlocProvider(create: (context) => AuthBloc()),
    BlocProvider(create: (context) => SellProductsBloc()),
    BlocProvider(create: (context) => ProductsBloc()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RouteNames.login,
            (route) => false,
          );
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        // demo colors for example
        darkTheme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.red,
            onPrimary: Colors.blue,
            secondary: Colors.white,
            onSecondary: Colors.pink,
            error: Colors.red,
            onError: Colors.pink,
            onSurface: Colors.black,
            surface: Colors.teal,
          ),
        ),
        themeMode: ThemeMode.light,
        // home: const HomePage(),
        navigatorKey: navigatorKey,
        initialRoute: RouteNames.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
