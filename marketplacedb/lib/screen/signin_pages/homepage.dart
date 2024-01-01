import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/screen_specific/Navigation.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
// import 'package:marketplacedb/config/icons.dart';
// import 'package:marketplacedb/config/containers.dart';
// import 'package:marketplacedb/config/textfields.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  int index = 0;

  // @override
  // Widget build(BuildContext context) => Scaffold(
  //       bottomNavigationBar: NavigationBar(
  //         destinations: [
  //           NavigationDestination(icon: PentagonIcon(), label: 'home')
  //         ],
  //       ),
  //     );

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: SearchAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          HomePageBannerSlider(banners: const [
            ImagesUtils.promotion1,
            ImagesUtils.promotion2,
            ImagesUtils.promotion3,
            ImagesUtils.promotion4,
            ImagesUtils.promotion5
          ])
        ]),
      ),
    ));
  }
}
