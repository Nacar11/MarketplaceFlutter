import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/screen/landing_pages/home_page/home_page_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MPHomeAppBar extends StatelessWidget {
  const MPHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PrimarySearchAppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: MPSizes.lg),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Discover Today's Specials with",
              style: Theme.of(context).textTheme.bodyMedium),
          Text(
            "MarketPlace World",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ]),
      ),
      showBackArrow: false,
      actions: const [ShoppingCartCounterIcon()],
    );
  }
}

class MPVerticalImageText extends StatelessWidget {
  const MPVerticalImageText({
    super.key,
    required this.imageUrl,
    required this.text,
    required this.onPressed,
    this.isNetworkImage = false,
  });

  final String imageUrl;
  final String text;
  final VoidCallback onPressed;
  final bool isNetworkImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MPSizes.sm),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            width: 65,
            height: 56,
            padding: const EdgeInsets.all(MPSizes.sm),
            decoration: BoxDecoration(
                color: MPColors.white,
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: MPRoundedImage(
                onPressed: onPressed,
                isNetworkImage: isNetworkImage,
                applyImageRadius: true,
                borderRadius: MPSizes.productImageRadius,
                imageUrl: imageUrl,
              ),
            )),
        const SizedBox(height: MPSizes.spaceBtwItems / 3),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 55,
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ])
      ]),
    );
  }
}

class HomePageBannerSlider extends StatelessWidget {
  HomePageBannerSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;
  final controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: banners
            .map((url) => MPRoundedImage(
                  imageUrl: url,
                  applyImageRadius: true,
                  width: 400,
                  height: 400,
                ))
            .toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          onPageChanged: (index, _) => controller.updatePageIndicator(index),
          autoPlay: false,
          enableInfiniteScroll: true,
        ),
      ),
      const SizedBox(height: 20),
      Obx(
        () => Row(mainAxisSize: MainAxisSize.min, children: [
          for (int i = 0; i < banners.length; i++)
            MPCircularContainer(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 4,
              backgroundColor: controller.carouselCurrentIndex.value == i
                  ? Colors.blue
                  : Colors.grey,
            ),
        ]),
      )
    ]);
  }
}
