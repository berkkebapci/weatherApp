import 'package:flutter/material.dart';

class UIColor {
  //main color 
  static Color primary = const Color(0xFF02B4BF);
  static Color secondary = const Color(0xFF032b5f);
  static Color black = const Color(0xFF000000);
  static Color white = const Color.fromARGB(255, 255, 255, 255);
  static Color red = const Color(0xFFFF5038);
  static Color formField = const Color(0xFFE7ECF6);
  static Color hintText = const Color.fromARGB(255, 103, 105, 107);
}

class UIGradient {
  static LinearGradient primaryGradient =  LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2196F3),
                  Color.fromARGB(255, 7, 39, 87),
                ],
              );

}
