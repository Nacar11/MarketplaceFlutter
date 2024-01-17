import 'package:flutter/material.dart';

import 'package:marketplacedb/common/widgets/screen_specific/landing_pages/home_page.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      MPPrimaryHeaderContainer(
          child: Column(children: [
        const MPHomeAppBar(),
        const SizedBox(height: MPSizes.spaceBtwSections),
        const MPSearchContainer(text: "Search Here"),
        const SizedBox(height: MPSizes.spaceBtwSections),
        const Padding(
          padding: EdgeInsets.only(left: MPSizes.defaultSpace),
          child:
              Column(children: [MPSectionHeading(title: 'Product Categories')]),
        ),
        const SizedBox(height: MPSizes.spaceBtwItems),
        SizedBox(
          height: MPSizes.imageThumbSize,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return const MPVerticalImageText();
              }),
        ),
      ])),
      SingleChildScrollView(
        child: Column(children: [
          HomePageBannerSlider(banners: const [
            MPImages.promotion1,
            MPImages.promotion2,
            MPImages.promotion3,
            MPImages.promotion4,
            MPImages.promotion5
          ])
        ]),
      ),
    ])));
  }
}











//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: SearchAppBar(),
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           HomePageBannerSlider(banners: const [
//             MPImages.promotion1,
//             MPImages.promotion2,
//             MPImages.promotion3,
//             MPImages.promotion4,
//             MPImages.promotion5
//           ])
//         ]),
//       ),
//     );
//   }
