import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page.dart';
import 'package:marketplacedb/screen/landing_pages/on_boarding_screen/on_boarding_screen.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:marketplacedb/util/theme/theme.dart';

void main() async {
  await MPLocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = MPLocalStorage();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MarketPlace',
      themeMode: ThemeMode.system,
      theme: MPAppTheme.lightTheme,
      darkTheme: MPAppTheme.darkTheme,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () {
            final token = storage.readData('token');
            if (token == null) {
              final isFirstTime = storage.readData('isFirstTime');
              if (isFirstTime != null) {
                return const FrontPage();
              } else {
                storage.clearAll();
                return const OnBoardingScreen();
              }
            } else {
              return const Navigation();
            }
          },
        ),
      ],
    );
  }
}
