import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class MPRoundedCoverImage extends StatelessWidget {
  const MPRoundedCoverImage({
    Key? key,
    this.padding = const EdgeInsets.only(top: MPSizes.md),
    this.onPressed,
    required this.imageUrl,
    required this.text,
    this.overlayColor,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final String imageUrl;
  final String text;

  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MPSizes.sm),
      child: GestureDetector(
        onTap: onPressed,
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                child: MPRoundedImage(
                  hasBorder: true,
                  imageUrl: imageUrl,
                  applyImageRadius: true,
                  borderRadius: MPSizes.borderRadiusMd,
                  overlayColor: overlayColor,
                ),
              ),
              Positioned(
                top: 50,
                left: 60,
                child: Text(text,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: MPColors.dark)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MPRoundedImage extends StatelessWidget {
  const MPRoundedImage({
    Key? key,
    this.padding,
    this.onPressed,
    this.width,
    this.height,
    this.overlayColor,
    this.applyImageRadius = false,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.backgroundColor = MPColors.light,
    this.isNetworkImage = false,
    this.borderRadius = MPSizes.xl,
    this.border,
    this.hasBorder = false,
  }) : super(key: key);

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final bool hasBorder;
  final Color backgroundColor;
  final BoxFit? boxFit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    // final dark = MPHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MPSizes.sm),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
                border: hasBorder ? border : null,
                borderRadius: BorderRadius.circular(borderRadius)),
            child: ClipRRect(
                borderRadius: applyImageRadius
                    ? BorderRadius.circular(borderRadius)
                    : BorderRadius.zero,
                child: Center(
                  child: isNetworkImage
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              ShimmerProgressContainer(
                                  height: height,
                                  width: width,
                                  circular: hasBorder),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) {
                            return Image(
                              height: height,
                              width: width,
                              image: imageProvider,
                              fit: boxFit,
                            );
                          })
                      : Image.asset(
                          imageUrl,
                          fit: boxFit,
                        ),
                ))),
      ),
    );
  }
}
