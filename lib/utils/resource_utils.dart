import 'package:flutter/material.dart';

class ImageHelper {
  static String getAssetsPath(String? imgName, {String format = 'png'}) {
    return 'assets/images/$imgName.$format';
  }

  static Image buildAssetImage(String? imgName,
      {double width = 24, double height = 24, String format = 'png',Color? color}) {
    return Image.asset(
      'assets/images/$imgName.$format',
      width: width,
      height: height,
      color: color,
    );
  }
}
