// ignore_for_file: no_logic_in_create_state, duplicate_ignore, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/data/models/CountryModel.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/listitem.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/listofcountry.dart';

class BillingAddress extends StatefulWidget {
  final String? navigation;
  const BillingAddress({Key? key, this.navigation}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<BillingAddress> createState() =>
      BillingAddressState(navigation: navigation ?? '');
}

class BillingAddressState extends State<BillingAddress> {
  final String? navigation;
  BillingAddressState({required this.navigation});
  Map<String, TextEditingController> myControllers = {
    "unitNumber": TextEditingController(),
    "addressLine1": TextEditingController(),
    "addressLine2": TextEditingController(),
    "city": TextEditingController(),
    "stateProvince": TextEditingController(),
    "postalCode": TextEditingController(),
  };

  final authController = AuthenticationController();
  CountryModel? selectedCountry;

  bool isBillingEmpty = true;

  @override
  void initState() {
    super.initState();
    for (final controller in myControllers.values) {
      controller.addListener(updateBillingEmptyStatus);
    }
    // Listen for changes in the text field and update isNameEmpty accordingly.
  }

  void billingaddressbutton(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            const Listitempage(hasSnackbar: 'billingAddressSuccess')));
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

  @override
  Widget build(BuildContext context) {
    bool isButtonDisabled = isBillingEmpty || selectedCountry == null;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      ),
      body: Column(
        children: [
          const Headertext(text: 'Start Selling/Buying'),
          const ContainerGuide(
            headerText: "Add your Billing Address",
            text: "We need this info for you to be a seller/customer",
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    UnderlineTextField(
                      controller: myControllers['unitNumber']!,
                      hintText: 'Enter your Unit No.',
                      labelText: 'Unit No.',
                      obscureText: false,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: UnderlineTextField(
                        controller: myControllers['addressLine1']!,
                        hintText: 'Enter your Address',
                        labelText: 'Address Line 1',
                        obscureText: false,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                      ),
                    ),
                    UnderlineTextField(
                      controller: myControllers['addressLine2']!,
                      hintText: 'Enter your 2nd Address',
                      labelText: 'Address Line 2 (optional)',
                      obscureText: false,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: UnderlineTextField(
                        controller: myControllers['city']!,
                        hintText: 'Enter your City',
                        labelText: 'City',
                        obscureText: false,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                      ),
                    ),
                    UnderlineTextField(
                      controller: myControllers['stateProvince']!,
                      hintText: 'Enter your State, Province, or Region',
                      labelText: 'State, province or region',
                      obscureText: false,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: UnderlineTextField(
                        controller: myControllers['postalCode']!,
                        hintText: 'Enter your Zip or Postal Code',
                        labelText: 'Zip or Postal Code',
                        obscureText: false,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => const ListOfCountryPage(),
                        ))
                            .then((selectedData) async {
                          if (selectedData != null) {
                            setState(() {
                              selectedCountry = selectedData;
                            });
                          }
                        });
                        print(selectedCountry?.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 2.0,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    selectedCountry?.name ?? 'Country Code',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Continue(
                        onTap: () async {
                          if (!isButtonDisabled) {
                            Map<String, String> data = {
                              "unit_number": myControllers["unitNumber"]!.text,
                              "address_line_1":
                                  myControllers["addressLine1"]!.text,
                              "address_line_2":
                                  myControllers["addressLine2"]!.text,
                              "city": myControllers["city"]!.text,
                              "region": myControllers["stateProvince"]!.text,
                              "postal_code": myControllers["postalCode"]!.text,
                              "country_id": selectedCountry!.id.toString(),
                            };
                            var response =
                                await controller.addBillingAddress(data);
                            print(response);
                            if (response == true) {
                              if (widget.navigation == 'pop') {
                                Navigator.of(context).pop(true);
                              } else {
                                billingaddressbutton(context);
                              }
                            } else {
                              showErrorHandlingSnackBar(
                                  context,
                                  'Error on Adding User Address, Please Try Again.',
                                  'error');
                            }
                          }
                        },
                        isDisabled:
                            isButtonDisabled, // Pass the isNameEmpty variable here
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
