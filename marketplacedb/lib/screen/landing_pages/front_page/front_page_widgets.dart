import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/networks/googleSignIn.dart';
import 'package:marketplacedb/screen/password_configuration/forget_password.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(height: 150, image: AssetImage(MPImages.appLogo)),
        Text(MPTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: MPSizes.sm),
        Text(MPTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        ValidatorField(
          controller: emailController,
          labelText: MPTexts.email,
          prefixIcon: const Icon(Iconsax.direct_right),
        ),
        const SizedBox(height: MPSizes.spaceBtwInputFields),
        PasswordValidatorField(
            controller: passwordController,
            labelText: MPTexts.password,
            prefixIcon: const Icon(Iconsax.password_check)),
      ],
    ));
  }
}

class LoginForgetPasswordRow extends StatelessWidget {
  const LoginForgetPasswordRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      TextButton(
          onPressed: () {
            Get.to(() => const ForgetPasswordPage());
          },
          child: const Text(MPTexts.forgetPassword)),
    ]);
  }
}

class MPDivider extends StatelessWidget {
  const MPDivider({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(
          child: Divider(
              color: isDarkMode ? MPColors.darkGrey : MPColors.grey,
              thickness: 2,
              indent: 60,
              endIndent: 5)),
      Text(MPTexts.loginDividerSignUpWith,
          style: Theme.of(context).textTheme.labelSmall),
      Flexible(
          child: Divider(
              color: isDarkMode ? MPColors.darkGrey : MPColors.grey,
              thickness: 2,
              indent: 5,
              endIndent: 60))
    ]);
  }
}

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: MPColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () async {
                AuthenticationController authenticationController =
                    AuthenticationController.instance;
                final userData = await GoogleSignAPI.login();
                await authenticationController.loginGoogle(
                    context, userData?.email);
              },
              icon: const Image(
                  width: MPSizes.iconMd,
                  height: MPSizes.iconMd,
                  image: AssetImage(MPImages.googleIcon)))),
      const SizedBox(width: MPSizes.spaceBtwItems),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: MPColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                  width: MPSizes.iconLg,
                  height: MPSizes.iconLg,
                  image: AssetImage(MPImages.facebookIcon))))
    ]);
  }
}
