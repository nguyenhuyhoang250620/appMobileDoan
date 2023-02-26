import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color whiteA7004c = fromHex('#4cffffff');

  static Color gray901 = fromHex('#1d222d');

  static Color black900 = fromHex('#000000');

  static Color bluegray400 = fromHex('#888888');

  static Color gray900 = fromHex('#1d232e');

  static Color indigo900 = fromHex('#00215f');

  static Color whiteA700 = fromHex('#ffffff');

  static Color indigo8004c = fromHex('#4c243a82');

  static Color gray50 = fromHex('#f8fafd');

  static Color green500 = fromHex('#33ad69');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
