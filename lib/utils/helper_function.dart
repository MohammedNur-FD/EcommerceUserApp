import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedDate(DateTime datetime, String format) {
  return DateFormat(format).format(datetime);
}

Future<bool> isConnectivityToInternet() async {
  final result = await Connectivity().checkConnectivity();
  // ignore: unrelated_type_equality_checks
  if (result == ConnectivityResult.mobile ||
      // ignore: unrelated_type_equality_checks
      result == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

void showMessage(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

