import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/dialogs/city_picker.dart';
import 'package:marketplacedb/common/widgets/dialogs/country_picker.dart';
import 'package:marketplacedb/common/widgets/dialogs/region_picker.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/add_billing_address/add_billing_address.widgets.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/add_billing_address/add_billing_address_controller.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/validators.dart';

class AddBillingAddress extends StatelessWidget {
  const AddBillingAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddBillingAddressController());
    return Scaffold(
      appBar: const PrimaryAppBarColored(title: MPTexts.getStarted),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MPSizes.defaultSpace),
          child: Column(
            children: [
              const Center(
                child: AnimationContainer(
                  width: .8,
                  height: 0.25,
                  animation: AnimationsUtils.addressSetup2,
                  duration: Duration(seconds: 10),
                ),
              ),
              const SizedBox(height: MPSizes.spaceBtwSections),
              CustomPhoneField(
                onChanged: (completePhoneNumber) {
                  controller.phoneNumber.value = completePhoneNumber;
                  controller.isPhoneValid.value =
                      controller.phoneNumber.value.length == 13;
                },
              ),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              Form(
                key: controller.unitNumberKey,
                child: ValidatorField(
                  validator: (value) => MPValidator.validateEmptyText(
                    value,
                    'Unit No.',
                  ),
                  onChanged: (value) {
                    controller.isUnitNumberValid.value =
                        controller.unitNumberKey.currentState!.validate() ==
                            true;
                  },
                  controller: controller.unitNumber,
                  prefixIcon: const Icon(Iconsax.house_2),
                  labelText: 'Unit No.',
                ),
              ),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              Form(
                key: controller.addressLine1Key,
                child: ValidatorField(
                  validator: (value) => MPValidator.validateEmptyText(
                    value,
                    'Address Line 1',
                  ),
                  onChanged: (value) {
                    controller.isAddressLine1Valid.value =
                        controller.addressLine1Key.currentState!.validate() ==
                            true;
                  },
                  controller: controller.addressLine1,
                  prefixIcon: const Icon(Iconsax.location),
                  labelText: 'Address Line 1',
                ),
              ),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              ValidatorField(
                controller: controller.addressLine2,
                prefixIcon: const Icon(Iconsax.location_tick),
                labelText: 'Address Line 2',
              ),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getXDialogContainer(
                          context: context,
                          title: "Select Country",
                          content: CountryPicker(
                            addBillingAddressController: controller,
                          ),
                        );
                      },
                      child: Obx(() => MPDialogContainer(
                            text: controller.selectedCountry.value.name ??
                                "Country",
                            icon: const Icon(Iconsax.courthouse),
                          )),
                    ),
                  ),
                  const SizedBox(width: MPSizes.spaceBtwInputFields),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        getXDialogContainer(
                          context: context,
                          title: "Select province or State",
                          content: RegionPicker(
                            addBillingAddressController: controller,
                          ),
                        );
                      },
                      child: Obx(() => MPDialogContainer(
                            text: controller.selectedRegion.value.name ??
                                "Province",
                            icon: const Icon(Iconsax.bank),
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        getXDialogContainer(
                          context: context,
                          title: "Select City",
                          content: CityPicker(
                            addBillingAddressController: controller,
                          ),
                        );
                      },
                      child: Obx(() => MPDialogContainer(
                            text: controller.selectedCity.value.name ?? "City",
                            icon: const Icon(Iconsax.house4),
                          )),
                    ),
                  ),
                  const SizedBox(width: MPSizes.spaceBtwInputFields),
                  Expanded(
                    child: Form(
                      key: controller.postalCodeKey,
                      child: ValidatorField(
                        validator: (value) => MPValidator.validateEmptyText(
                          value,
                          'Zip Code',
                        ),
                        onChanged: (value) {
                          controller.isPostalCodeValid.value = controller
                                  .postalCodeKey.currentState!
                                  .validate() ==
                              true;
                        },
                        controller: controller.postalCode,
                        prefixIcon: const Icon(Iconsax.clipboard_export),
                        labelText: 'Zip Code',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MPSizes.spaceBtwSections),
              Obx(() => MPPrimaryButton(
                    onPressed: () async {
                      await controller.addBillingAddress();
                    },
                    isLoading: controller.isLoading.value,
                    isDisabled: !controller.isUnitNumberValid.value ||
                        !controller.isAddressLine1Valid.value ||
                        !controller.isPostalCodeValid.value ||
                        controller.isPhoneValid.value == false ||
                        controller.selectedCity.value.id == null,
                    text: 'Add Address',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
