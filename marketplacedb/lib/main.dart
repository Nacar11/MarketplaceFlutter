import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/screen/front_page.dart';
import 'package:marketplacedb/screen/on_boarding_screen.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:marketplacedb/util/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
      initialRoute: () {
        final token = storage.readData('token');
        if (token == null) {
          // storage.clearAll();
          final isFirstTime = storage.readData('isFirstTime');
          if (isFirstTime != null) {
            return '/frontpage';
          } else {
            storage.clearAll();
            return '/OnBoardingScreen';
          }
        } else {
          return '/navigation';
        }
      }(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/frontpage':
            return MaterialPageRoute(builder: (context) => const FrontPage());
          case '/navigation':
            return MaterialPageRoute(builder: (context) => const Navigation());
          case '/OnBoardingScreen':
            return MaterialPageRoute(
                builder: (context) => const OnBoardingScreen());
        }
        return null;
      },
    );
  }
}
