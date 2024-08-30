import 'package:ecom_boni_user/auth/firebase_auth_service.dart';
import 'package:ecom_boni_user/custom_widgets/drawer_list_tile.dart';
import 'package:ecom_boni_user/pages/login_page.dart';
import 'package:ecom_boni_user/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 200,
          ),
          DrawerListTile(
            icon: Icons.person,
            text: 'My Profile',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ProfilePage.routeName);
            },
          ),
          DrawerListTile(
            icon: Icons.list_alt,
            text: 'Orders',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerListTile(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              FirebaseAuthService.logoutUser().then(
                  (_) => Navigator.pushNamed(context, LoginPage.routeName));
            },
          ),
        ],
      ),
    );
  }
}
