import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/bindings/general_bindings.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page.dart';
import 'package:marketplacedb/screen/landing_pages/on_boarding_page/on_boarding_page.dart';
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
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.light,
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
