import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/screen_specific/sign_up_pages/name.dart';
import 'package:marketplacedb/screen/landing_pages/front_page.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class PasswordChangeSuccessPage extends StatefulWidget {
  const PasswordChangeSuccessPage({super.key});

  @override
  State<PasswordChangeSuccessPage> createState() =>
      PasswordChangeSuccessPageState();
}

class PasswordChangeSuccessPageState extends State<PasswordChangeSuccessPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAll(() => const FrontPage());
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(MPSizes.defaultSpace),
          child: Center(
            child: Column(children: [
              const SizedBox(height: MPSizes.spaceBtwSections * 3),
              const AnimationContainer(
                  animation: AnimationsUtils.success1,
                  duration: Duration(seconds: 4)),
              Text(
                MPTexts.passwordChangeSuccessfulTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: MPSizes.spaceBtwItems),
              Text(
                MPTexts.passwordChangeSuccessfulSubTitle,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ]),
          ),
        ));
  }
}
