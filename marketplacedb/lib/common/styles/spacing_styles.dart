import 'package:flutter/material.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class MPSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: MPSizes.appBarHeight,
    bottom: MPSizes.defaultSpace,
    left: MPSizes.defaultSpace,
    right: MPSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry signUpProcessPadding = EdgeInsets.all(
    MPSizes.defaultSpace,
  );
}
