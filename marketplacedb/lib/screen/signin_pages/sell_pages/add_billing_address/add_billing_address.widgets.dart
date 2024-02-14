import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class MPDialogContainer extends StatelessWidget {
  const MPDialogContainer({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MPHelperFunctions.isDarkMode(context);
    return MPCircularContainer(
        backgroundColor: Colors.transparent,
        borderColor: isDarkMode ? MPColors.white : MPColors.black,
        radius: MPSizes.cardRadiusSm,
        height: 60,
        showBorder: true,
        child: Padding(
          padding: const EdgeInsets.only(left: MPSizes.sm),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            icon,
            const SizedBox(width: MPSizes.sm),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ]),
        ));
  }
}

class AddBillingAddressShimmerContainer extends StatelessWidget {
  const AddBillingAddressShimmerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MPHelperFunctions.isDarkMode(context);
    return Container(
      color: isDarkMode ? MPColors.dark : MPColors.white,
      child: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MPSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(height: MPSizes.defaultSpace / 2),
              ShimmerProgressContainer(
                height: 150,
              ),
              SizedBox(height: MPSizes.spaceBtwSections),
              ShimmerProgressContainer(
                height: 60,
              ),
              SizedBox(height: MPSizes.spaceBtwInputFields),
              ShimmerProgressContainer(
                height: 60,
              ),
              SizedBox(height: MPSizes.spaceBtwInputFields),
              ShimmerProgressContainer(
                height: 60,
              ),
              SizedBox(height: MPSizes.spaceBtwInputFields),
              ShimmerProgressContainer(
                height: 60,
              ),
              SizedBox(height: MPSizes.spaceBtwInputFields),
              ShimmerProgressContainer(
                height: 60,
              ),
              SizedBox(height: MPSizes.spaceBtwInputFields),
              ShimmerProgressContainer(
                height: 60,
              ),
              SizedBox(height: MPSizes.spaceBtwSections),
              ShimmerProgressContainer(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> getXDialogContainer({
  required String title,
  required Widget content,
  required BuildContext context,
}) {
  return Get.defaultDialog(
    title: title,
    titlePadding: const EdgeInsets.all(MPSizes.lg),
    titleStyle: Theme.of(context).textTheme.headlineSmall!,
    content: content,
  );
}
