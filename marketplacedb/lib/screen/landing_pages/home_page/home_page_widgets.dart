import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/custom_shapes/custom_curved_edge_widget.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/device/device_utility.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/controllers/inner_controllers/home_screen_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MPPrimaryHeaderContainer extends StatelessWidget {
  const MPPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
        child: SizedBox(
      height: 350,
      child: Container(
        color: MPColors.buttonPrimary,
        padding: const EdgeInsets.only(bottom: 0),
        child: Stack(children: [
          Positioned(
            top: -150,
            right: -300,
            child: MPCircularContainer(
                width: 400,
                height: 400,
                radius: 400,
                backgroundColor: MPColors.white.withOpacity(0.1)),
          ),
          Positioned(
              bottom: -250,
              right: -300,
              child: MPCircularContainer(
                  width: 400,
                  height: 400,
                  radius: 400,
                  backgroundColor: MPColors.white.withOpacity(0.1))),
          Positioned(
              top: -300,
              left: -200,
              child: MPCircularContainer(
                  width: 400,
                  height: 400,
                  radius: 400,
                  backgroundColor: MPColors.white.withOpacity(0.1))),
          child
        ]),
      ),
    ));
  }
}

class ShoppingCartCounterIcon extends StatelessWidget {
  const ShoppingCartCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
  });

  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.shopping_bag, color: MPColors.white)),
      Positioned(
        right: 0,
        child: Container(
            width: MPSizes.circularBadgeSize,
            height: MPSizes.circularBadgeSize,
            decoration: BoxDecoration(
                color: MPColors.black,
                borderRadius: BorderRadius.circular(
                  MPSizes.circularBadgeSize,
                )),
            child: Center(
                child: Text('2',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: MPColors.white)))),
      )
    ]);
  }
}

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
      actions: [
        ShoppingCartCounterIcon(onPressed: () {}, iconColor: MPColors.white)
      ],
    );
  }
}

class MPSearchContainer extends StatelessWidget {
  const MPSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MPSizes.defaultSpace),
      child: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: SearchAppBarDelegate());
        },
        child: Container(
            width: MPDeviceUtils.getScreenWidth(),
            padding: const EdgeInsets.all(MPSizes.inputFieldRadius),
            decoration: BoxDecoration(
                color: showBackground
                    ? dark
                        ? MPColors.dark
                        : MPColors.light
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(MPSizes.cardRadiusLg),
                border: showBorder ? Border.all(color: MPColors.black) : null),
            child: Row(children: [
              Icon(icon, color: dark ? MPColors.white : MPColors.darkerGrey),
              const SizedBox(width: MPSizes.spaceBtwInputFields),
              Text(text, style: Theme.of(context).textTheme.bodyMedium),
            ])),
      ),
    );
  }
}

class MPSectionHeading extends StatelessWidget {
  const MPSectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = false,
    required this.title,
    this.buttonTile = 'View All',
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTile;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
      if (showActionButton)
        TextButton(
            onPressed: onPressed,
            child:
                Text(buttonTile, style: Theme.of(context).textTheme.bodySmall))
    ]);
  }
}

class MPVerticalImageText extends StatelessWidget {
  const MPVerticalImageText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MPSizes.spaceBtwItems),
      child: Column(children: [
        Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(MPSizes.sm),
            decoration: BoxDecoration(
                color: MPColors.white,
                borderRadius: BorderRadius.circular(100)),
            child: const Center(
                child: Image(
                    image: AssetImage(MPImages.maleCategoryIcon),
                    fit: BoxFit.cover,
                    color: MPColors.dark))),
        const SizedBox(height: MPSizes.spaceBtwItems / 3),
        SizedBox(
          width: 55,
          child: Text(
            'Men Category',
            style: Theme.of(context).textTheme.labelLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ]),
    );
  }
}

class MPRoundedImage extends StatelessWidget {
  const MPRoundedImage({
    Key? key,
    this.border,
    this.padding,
    this.onPressed,
    this.width,
    this.height,
    this.applyImageRadius = false,
    required this.imageUrl,
    this.boxFit = BoxFit.contain,
    this.backgroundColor = MPColors.light,
    this.isNetworkImage = false,
    this.borderRadius = MPSizes.xl,
  }) : super(key: key);

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? boxFit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MPSizes.sm),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
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
