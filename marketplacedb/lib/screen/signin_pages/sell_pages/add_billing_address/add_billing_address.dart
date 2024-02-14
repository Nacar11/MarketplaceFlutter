import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/common/widgets/dialogs/city_picker.dart';
import 'package:marketplacedb/common/widgets/dialogs/country_picker.dart';
import 'package:marketplacedb/common/widgets/dialogs/region_picker.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
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
  Map<String, TextEditingController> myControllers = {
    "unitNumber": TextEditingController(),
    "addressLine1": TextEditingController(),
    "addressLine2": TextEditingController(),
    "city": TextEditingController(),
    "stateProvince": TextEditingController(),
    "postalCode": TextEditingController(),
  };

  bool isBillingEmpty = true;

  @override
  void initState() {
    super.initState();
    for (final controller in myControllers.values) {
      controller.addListener(updateBillingEmptyStatus);
    }
  }

  void updateBillingEmptyStatus() {
    setState(() {
      isBillingEmpty = myControllers.values
          .where((controller) =>
              controller !=
              myControllers['addressLine2']) // Exclude optionalController
          .any((controller) => controller.text.isEmpty);
    });
  }

  @override
  void dispose() {
    for (final controller in myControllers.values) {
      controller.removeListener(updateBillingEmptyStatus);
      controller.dispose();
    }
    super.dispose();
  }

  String phoneNumberController = '';
  @override
  Widget build(BuildContext context) {
    final addBillingAddressController = Get.put(AddBillingAddressController());
    bool isButtonDisabled = isBillingEmpty;
    return Scaffold(
        appBar: const PrimaryAppBarColored(title: MPTexts.getStarted),
        body: Obx(
          () => addBillingAddressController.isLoading.value
              ? const Center(child: AddBillingAddressShimmerContainer())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(MPSizes.defaultSpace),
                    child: Form(
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
                                // isPhoneValid = completePhoneNumber.length == 13;
                              });
                            },
                          ),
                          const SizedBox(height: MPSizes.spaceBtwInputFields),
                          ValidatorField(
                            controller: myControllers['unitNumber']!,
                            prefixIcon: const Icon(Iconsax.house_2),
                            labelText: 'Unit No.',
                          ),
                          const SizedBox(height: MPSizes.spaceBtwInputFields),
                          ValidatorField(
                            controller: myControllers['addressLine1']!,
                            prefixIcon: const Icon(Iconsax.location),
                            labelText: 'Address Line 1',
                          ),
                          const SizedBox(height: MPSizes.spaceBtwInputFields),
                          ValidatorField(
                            controller: myControllers['addressLine2']!,
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
                              const SizedBox(
                                  width: MPSizes.spaceBtwInputFields),
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
                              const SizedBox(
                                  width: MPSizes.spaceBtwInputFields),
                              Expanded(
                                child: ValidatorField(
                                  controller: myControllers['postalCode']!,
                                  prefixIcon:
                                      const Icon(Iconsax.clipboard_export),
                                  labelText: 'Zip Code',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: MPSizes.spaceBtwSections),
                          MPPrimaryButton(
                            onPressed: () async {
                              if (isButtonDisabled) {
                                // Map<String, String> data = {
                                //   "unit_number":
                                //       myControllers["unitNumber"]!.text,
                                //   "address_line_1":
                                //       myControllers["addressLine1"]!.text,
                                //   "address_line_2":
                                //       myControllers["addressLine2"]!.text,
                                //   "city": myControllers["city"]!.text,
                                //   "region":
                                //       myControllers["stateProvince"]!.text,
                                //   "postal_code":
                                //       myControllers["postalCode"]!.text,
                                //   "country_id": addBillingAddressController
                                //       .selectedCountry.value.id
                                //       .toString(),
                                // };
                                // var response =
                                //     await controller.addBillingAddress(data);
                                // print(response);
                                // if (response == true) {
                                //   if (isBillingEmpty) {
                                //     Navigator.of(context).pop(true);
                                //   } else {}
                                // } else {
                                //   errorSnackBar(
                                //       context,
                                //       'Error on Adding User Address, Please Try Again.',
                                //       'error');
                                // }
                                Get.offAll(() => const Navigation());
                                getSnackBar("Successful",
                                    'Address Successfully Added', false);
                              }
                            },
                            // isDisabled: isButtonDisabled,
                            text:
                                'Add Address', // Pass the isNameEmpty variable here
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}



 // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context)
                //         .push(MaterialPageRoute(
                //       builder: (context) => const ListOfCountryPage(),
                //     ))
                //         .then((selectedData) async {
                //       if (selectedData != null) {
                //         setState(() {
                //           selectedCountry = selectedData;
                //         });
                //       }
                //     });
                //     print(selectedCountry?.id);
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 10),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10.0),
                //         border: Border.all(
                //           color: const Color.fromARGB(255, 0, 0, 0),
                //           width: 2.0,
                //         ),
                //       ),
                //       child: Row(
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.all(15.0),
                //             child: Text(
                //               selectedCountry?.name ?? 'Country Code',
                //               style: const TextStyle(
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),