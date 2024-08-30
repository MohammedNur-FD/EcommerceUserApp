import 'package:ecom_boni_user/auth/firebase_auth_service.dart';
import 'package:ecom_boni_user/custom_widgets/screen.dart';
import 'package:ecom_boni_user/pages/login_page.dart';
import 'package:ecom_boni_user/pages/product_list_page.dart';
import 'package:flutter/material.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});
  static const String routeName = '/launcher';

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      if (FirebaseAuthService.currentUser == null) {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, ProductListPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shop,
                size: 200,
                color: Colors.white,
              ),
              SizedBox(
                height: 150,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.black,
                strokeWidth: 3,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}