import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/controllers/inner_controllers/home_screen_controller.dart';

class HomeBannerImage extends StatelessWidget {
  const HomeBannerImage({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.width,
    this.height,
    this.applyImageRadius = true,
    required this.imageUrl,
    this.boxFit = BoxFit.contain,
    this.backgroundColor = Colors.lightBlue,
    this.isNetworkImage = false,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? boxFit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius = 10;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
                border: border,
                borderRadius: BorderRadius.circular(borderRadius)),
            child: ClipRRect(
                borderRadius: applyImageRadius
                    ? BorderRadius.circular(borderRadius)
                    : BorderRadius.zero,
                child: Image(
                    image: isNetworkImage
                        ? NetworkImage(imageUrl)
                        : AssetImage(imageUrl) as ImageProvider,
                    fit: boxFit))),
      ),
    );
  }
}

class MPCircularContainer extends StatelessWidget {
  const MPCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.margin,
    this.padding = 0,
    this.backgroundColor = Colors.white,
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsets? margin;
  final double padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: margin,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        child: child);
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
            .map((url) => HomeBannerImage(
                  imageUrl: url,
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
