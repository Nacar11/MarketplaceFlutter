import 'package:flutter/material.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class MPBorderRadiusStyle {
  static const BorderRadiusGeometry bottomSheetBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(MPSizes.borderRadiusLg),
    topRight: Radius.circular(MPSizes.borderRadiusLg),
  );
}
