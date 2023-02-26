import 'package:flutter/material.dart';
import 'package:app_mobile_doan/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get fillGray50 => BoxDecoration(
        color: ColorConstant.gray50,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get fillWhiteA7004c => BoxDecoration(
        color: ColorConstant.whiteA7004c,
      );
  static BoxDecoration get txtFillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder16 = BorderRadius.circular(
    getHorizontalSize(
      16.00,
    ),
  );

  static BorderRadius roundedBorder25 = BorderRadius.circular(
    getHorizontalSize(
      25.00,
    ),
  );

  static BorderRadius roundedBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12.92,
    ),
  );

  static BorderRadius circleBorder10 = BorderRadius.circular(
    getHorizontalSize(
      10.00,
    ),
  );

  static BorderRadius txtCircleBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12.00,
    ),
  );
}
