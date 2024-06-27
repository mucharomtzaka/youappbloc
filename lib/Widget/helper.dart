
import 'package:flutter/material.dart';

class WidgetHelper{
  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      showSnackBarFun(context, String txt, color) async {
    SnackBar snackBar = SnackBar(
        content: Text(txt,
            style: const TextStyle(fontSize: 12, color: Colors.white)),
        backgroundColor: color,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating);
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}