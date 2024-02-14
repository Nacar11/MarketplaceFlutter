import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/password_configuration/code_verification.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  bool isEmailValid = false;
  AuthenticationController authController = AuthenticationController.instance;
  late TextEditingController emailController;
  MPLocalStorage localStorage = MPLocalStorage();
  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(MPSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MPTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: MPSizes.spaceBtwItems),
            Text(
              MPTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            ValidatorField(
              onChanged: (value) {
                //modify isEmailValid
                setState(() {
                  isEmailValid = value.contains("@") && value.isNotEmpty;
                  print(isEmailValid);
                });
              },
              controller: emailController,
              labelText: MPTexts.email,
              prefixIcon: const Icon(Iconsax.direct_right),
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            Obx(() => MPPrimaryButton(
                  text: MPTexts.continueText,
                  isDisabled: !isEmailValid,
                  isLoading: authController.isLoading.value,
                  onPressed: () async {
                    var response = await authController
                        .getEmailVerificationCode(emailController.text);
                    print(response);
                    if (response['message'] == 'success') {
                      localStorage.saveData(
                          'emailVerificationCode', response['code'].toString());
                      localStorage.saveData(
                          'emailResetPassword', emailController.text);

                      Get.to(() => const CodeVerificationForgetPasswordPage());
                    } else {
                      getSnackBar(response['message'], 'Error', false);
                      // showErrorHandlingSnackBar(
                      //     context, response['message'], 'error');
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
