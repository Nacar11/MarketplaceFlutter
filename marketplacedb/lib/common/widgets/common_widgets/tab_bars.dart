// import 'package:flutter/material.dart';




// class MPTabBar extends StatelessWidget implements PreferredSizeWidget {
//   const MPTabBar({super.key, required this.tabs, required this.onTabPressed});

//   final List<Widget> tabs;
//   final Function(int) onTabPressed;
//   
//   @override
//   Widget build(BuildContext context) {
//     final dark = MPHelperFunctions.isDarkMode(context);
//     return Material(
//         color: dark ? MPColors.black : MPColors.white,
//         child: TabBar(
//           tabs: tabs,
//           onTap: onTabPressed;
//           isScrollable: true,
//           indicatorColor: MPColors.primary,
//           labelColor: dark ? MPColors.white : MPColors.primary,
//           unselectedLabelColor: MPColors.darkGrey,
//         ));
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(MPDeviceUtils.getAppBarHeight());
// }
