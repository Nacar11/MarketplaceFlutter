import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/screen/front_page.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketplacedb/util/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final storage = GetStorage();
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MarketPlace',
        themeMode: ThemeMode.system,
        theme: MPAppTheme.lightTheme,
        darkTheme: MPAppTheme.darkTheme,

        // theme: ThemeData(
        //   textTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(
        //     bodyMedium: GoogleFonts.nunito(textStyle: textTheme.bodyMedium),
        //   ),

        // ),
        initialRoute: storage.read('token') == null
            ? '/frontpage'
            : '/navigation', // Set initial route
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/frontpage':
              return MaterialPageRoute(builder: (context) => const FrontPage());
            case '/navigation':
              return MaterialPageRoute(
                  builder: (context) => const Navigation());
            default:
              return MaterialPageRoute(builder: (context) => const FrontPage());
          }
        },
      ),
      designSize: const Size(360, 800),
    );
  }
}
