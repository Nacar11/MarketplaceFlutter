import 'package:flutter/material.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';

class MPShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: MPColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalProductShadow = BoxShadow(
      color: MPColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
