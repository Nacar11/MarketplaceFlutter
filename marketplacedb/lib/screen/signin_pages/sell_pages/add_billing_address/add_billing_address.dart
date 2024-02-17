import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/dialogs/city_picker.dart';
import 'package:marketplacedb/common/widgets/dialogs/country_picker.dart';
import 'package:marketplacedb/common/widgets/dialogs/region_picker.dart';
import 'package:marketplacedb/screen/signin_pages/sell_pages/add_billing_address/add_billing_address.widgets.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/signin_pages/sell_pages/add_billing_address/add_billing_address_controller.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class AddBillingAddress extends StatefulWidget {
  const AddBillingAddress({Key? key}) : super(key: key);

  @override
  State<AddBillingAddress> createState() => AddBillingAddressState();
}

class AddBillingAddressState extends State<AddBillingAddress> {
  final addBillingAddressController = Get.put(AddBillingAddressController());

  String phoneNumberController = '';
  bool isPhoneValid = false;
  TextEditingController unitNumber = TextEditingController();
  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();
  TextEditingController postalCode = TextEditingController();

  bool isButtonDisabled = true;

  void onFieldsChanged() {
    print(addBillingAddressController.selectedCity.value.id);
    isButtonDisabled = unitNumber.text.isEmpty ||
        addressLine1.text.isEmpty ||
        postalCode.text.isEmpty ||
        isPhoneValid == false;

    print(isButtonDisabled);
  }

  @override
  void initState() {
    super.initState();
    unitNumber.addListener(onFieldsChanged);
    addressLine1.addListener(onFieldsChanged);
    addressLine2.addListener(onFieldsChanged);
    postalCode.addListener(onFieldsChanged);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    duration: Duration(seconds: 10)),
              ),
              const SizedBox(height: MPSizes.spaceBtwSections),
              CustomPhoneField(
                onValidityChanged: (completePhoneNumber) {
                  setState(() {
                    phoneNumberController = completePhoneNumber;
                    isPhoneValid = completePhoneNumber.length == 13;
                    onFieldsChanged();
                  });
                },
              ),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              ValidatorField(
                onChanged: (value) => setState(() {
                  onFieldsChanged();
                }),
                controller: unitNumber,
                prefixIcon: const Icon(Iconsax.house_2),
                labelText: 'Unit No.',
              ),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              ValidatorField(
                onChanged: (value) => setState(() {
                  onFieldsChanged();
                }),
                controller: addressLine1,
                prefixIcon: const Icon(Iconsax.location),
                labelText: 'Address Line 1',
              ),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              ValidatorField(
                controller: addressLine2,
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
                              addBillingAddressController:
                                  addBillingAddressController),
                        );
                      },
                      child: Obx(() => MPDialogContainer(
                            text: addBillingAddressController
                                    .selectedCountry.value.name ??
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
                                addBillingAddressController:
                                    addBillingAddressController));
                      },
                      child: Obx(() => MPDialogContainer(
                          text: addBillingAddressController
                                  .selectedRegion.value.name ??
                              "Province",
                          icon: const Icon(Iconsax.bank))),
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
                                addBillingAddressController:
                                    addBillingAddressController));
                      },
                      child: Obx(() => MPDialogContainer(
                          text: addBillingAddressController
                                  .selectedCity.value.name ??
                              "City",
                          icon: const Icon(Iconsax.house4))),
                    ),
                  ),
                  const SizedBox(width: MPSizes.spaceBtwInputFields),
                  Expanded(
                    child: ValidatorField(
                      onChanged: (value) => setState(() {
                        onFieldsChanged();
                      }),
                      controller: postalCode,
                      prefixIcon: const Icon(Iconsax.clipboard_export),
                      labelText: 'Zip Code',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MPSizes.spaceBtwSections),
              Obx(() => MPPrimaryButton(
                    onPressed: () async {
                      Map<String, String> data = {
                        "contact_number": phoneNumberController,
                        "unit_number": unitNumber.text,
                        "address_line_1": addressLine1.text,
                        "address_line_2": addressLine2.text,
                        "city_id": addBillingAddressController
                            .selectedCity.value.id
                            .toString(),
                        "region_id": addBillingAddressController
                            .selectedRegion.value.id
                            .toString(),
                        "postal_code": postalCode.text,
                        "country_id": addBillingAddressController
                            .selectedCountry.value.id
                            .toString(),
                      };
                      await addBillingAddressController.addBillingAddress(data);
                    },
                    isLoading: addBillingAddressController.isLoading.value,
                    isDisabled: isButtonDisabled ||
                        addBillingAddressController.selectedCity.value.id ==
                            null,
                    text: 'Add Address', // Pass the isNameEmpty variable here
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
