import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplacedb/screen/front_page.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(
            bodyMedium: GoogleFonts.nunito(textStyle: textTheme.bodyMedium),
          ),

          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
        ),
        initialRoute: storage.read('token') == null
            ? '/frontpage'
            : '/navigation', // Set initial route
        onGenerateRoute: (settings) {
          // Define routes using onGenerateRoute
          switch (settings.name) {
            case '/frontpage':
              return MaterialPageRoute(builder: (context) => const Frontpage());
            case '/navigation':
              return MaterialPageRoute(
                  builder: (context) => const Navigation());
            default:
              return MaterialPageRoute(builder: (context) => const Frontpage());
          }
        },
      ),
      designSize: const Size(360, 800),
    );
  }
}
