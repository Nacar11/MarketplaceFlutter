import 'package:flutter/material.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class MPDividerWithText extends StatelessWidget {
  const MPDividerWithText({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MPHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: isDarkMode ? MPColors.darkGrey : MPColors.grey,
            thickness: 2,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(text, style: Theme.of(context).textTheme.labelSmall),
        Flexible(
          child: Divider(
            color: isDarkMode ? MPColors.darkGrey : MPColors.grey,
            thickness: 2,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
