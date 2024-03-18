import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';

class MPHelperFunctions {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // static String currency(BuildContext context) {
  //   Locale locale = Localizations.localeOf(context);
  //   var format =
  //       NumberFormat.simpleCurrency(locale: locale.toString(), name: 'PHP');
  //   return format.currencySymbol;
  // }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String capitalizeFirstLetter(String value) {
    if (value.isNotEmpty) {
      return value.substring(0, 1).toUpperCase() + value.substring(1);
    }
    return value;
  }

  static final Map<int, String> monthAbbreviations = {
    DateTime.january: 'Jan',
    DateTime.february: 'Feb',
    DateTime.march: 'Mar',
    DateTime.april: 'Apr',
    DateTime.may: 'May',
    DateTime.june: 'Jun',
    DateTime.july: 'Jul',
    DateTime.august: 'Aug',
    DateTime.september: 'Sept',
    DateTime.october: 'Oct',
    DateTime.november: 'Nov',
    DateTime.december: 'Dec',
  };

  static String convertDate(String orderDate) {
    DateTime dateTime = DateTime.parse(orderDate);

    String day = dateTime.day.toString().padLeft(2, '0');
    String monthName = monthAbbreviations[dateTime.month]!;
    String year = dateTime.year.toString();

    return '$day $monthName $year';
  }

  static String orderDescription(String orderStatus) {
    switch (orderStatus) {
      case 'Processing':
        return 'Your order is still being processed.';
      case 'Cancelled':
        return 'You cancelled this order.';
      case 'Shipping':
        return 'Your order is being shipped.';
      case 'Delivering':
        return 'Your order is out for delivery.';
      case 'Completed':
        return 'Your order has been completed.';
      default:
        return 'Unknown order status';
    }
  }

  static Widget orderTextDesign(String orderStatus, BuildContext context) {
    TextStyle textStyle;

    switch (orderStatus) {
      case 'Processing':
        textStyle = Theme.of(context)
            .textTheme
            .bodyLarge!
            .apply(color: MPColors.secondary, fontWeightDelta: 1);
        break;
      case 'Cancelled':
        textStyle = Theme.of(context).textTheme.bodyLarge!.apply(
            color: Colors.red,
            fontWeightDelta: 1,
            decoration: TextDecoration.lineThrough);
        break;
      default:
        textStyle = Theme.of(context)
            .textTheme
            .bodyLarge!
            .apply(color: MPColors.secondary, fontWeightDelta: 1);
    }

    return Text(
      orderStatus,
      style: textStyle,
    );
  }

  static double expandedHeightTabBar(int nSubCategory) {
    if (nSubCategory <= 4) {
      return 400;
    } else if (nSubCategory <= 6) {
      return 500;
    } else if (nSubCategory <= 8) {
      return 700;
    } else {
      return 200;
    }
  }
}
