import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/password_configuration/code_verification.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

final emailController = TextEditingController();
AuthenticationController authController = AuthenticationController.instance;

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(MPSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(MPTexts.forgetPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: MPSizes.spaceBtwItems),
              Text(MPTexts.forgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: MPSizes.spaceBtwSections),
              ValidatorField(
                controller: emailController,
                labelText: MPTexts.email,
                prefixIcon: const Icon(Iconsax.direct_right),
              ),
              const SizedBox(height: MPSizes.spaceBtwSections),
              Obx(() => MPPrimaryButton(
                    text: "Continue",
                    isLoading: authController.isLoading.value,
                    onPressed: () async {
                      var response = await authController
                          .getEmailVerificationCode(emailController.text);

                      if (response['message'] == 'success') {
                        MPLocalStorage localStorage = MPLocalStorage();
                        localStorage.saveData(
                            'emailVerificationCode', response['code']);
                        localStorage.saveData(
                            'emailResetPassword', emailController.text);

                        Get.to(
                            () => const CodeVerificationForgetPasswordPage());
                      } else {
                        // ignore: use_build_context_synchronously
                        showErrorHandlingSnackBar(
                            context, response['message'], 'error');
                      }
                    },
                  ))
            ])));
  }
}
