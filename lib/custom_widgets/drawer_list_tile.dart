import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  void Function()? onTap;
  DrawerListTile(
      {super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon),
    );
  }
}
