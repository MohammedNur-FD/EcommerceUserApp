import 'package:ecom_boni_user/pages/cart_page.dart';
import 'package:ecom_boni_user/pages/customer_info_page.dart';
import 'package:ecom_boni_user/pages/launcher_page.dart';
import 'package:ecom_boni_user/pages/login_page.dart';
import 'package:ecom_boni_user/pages/order_confirmation_page.dart';
import 'package:ecom_boni_user/pages/order_success_page.dart';
import 'package:ecom_boni_user/pages/product_list_page.dart';
import 'package:ecom_boni_user/pages/profile_page.dart';
import 'package:ecom_boni_user/pages/sign_up_page.dart';
import 'package:ecom_boni_user/provider/cart_provider.dart';
import 'package:ecom_boni_user/provider/customer_provider.dart';
import 'package:ecom_boni_user/provider/order_provider.dart';
import 'package:ecom_boni_user/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAGrt5zqz-f2wHHkSHiAQSf5SA8t0u_oJw",
          appId: "1:1075573865798:android:1ecfc93ea0ea6fd19df947",
          messagingSenderId: "1075573865798",
          projectId: "pntecommerce-c6f0e"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadowColor: Colors.black,
              elevation: 10,
              foregroundColor: Colors.white,
              iconColor: Colors.white,
              backgroundColor: Colors.black,
            ),
          ),
          textTheme: const TextTheme(
            headlineSmall: TextStyle(color: Colors.white, fontSize: 18),
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 113, 123, 180),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        ),
        home: const LauncherPage(),
        routes: {
          LauncherPage.routeName: (context) => const LauncherPage(),
          LoginPage.routeName: (context) => const LoginPage(),
          SignUpPage.routeName: (context) => const SignUpPage(),
          ProductListPage.routeName: (context) => const ProductListPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          CartPage.routeName: (context) => const CartPage(),
          CustomerInfoPage.routeName: (context) => const CustomerInfoPage(),
          OrderConfirmationPage.routeName: (context) =>
              const OrderConfirmationPage(),
          OrderSuccessPage.routeName: (context) => const OrderSuccessPage(),
        },
      ),
    );
  }
}
