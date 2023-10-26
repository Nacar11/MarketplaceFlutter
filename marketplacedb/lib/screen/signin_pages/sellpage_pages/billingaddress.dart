import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/models/CountryModel.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/listitem.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/listofcountry.dart';

class BillingAddress extends StatefulWidget {
  const BillingAddress({Key? key}) : super(key: key);

  @override
  State<BillingAddress> createState() => BillingAddressState();
}

class BillingAddressState extends State<BillingAddress> {
  final unitnumber = TextEditingController();
  final addressline1 = TextEditingController();
  final addressline2 = TextEditingController();
  final city = TextEditingController();
  final stateprovince = TextEditingController();
  final postalcode = TextEditingController();
  final country = TextEditingController();
  final authController = AuthenticationController();
  CountryModel? selectedCountry;

  bool isNameEmpty = true;

  @override
  void initState() {
    super.initState();
    country.addListener(() {
      setState(() {
        if (country.text.isEmpty &&
            postalcode.text.isEmpty &&
            stateprovince.text.isEmpty &&
            city.text.isEmpty &&
            addressline1.text.isEmpty) {
          isNameEmpty = true;
        } else {
          isNameEmpty = false;
        }
      });
    });
    // Listen for changes in the text field and update isNameEmpty accordingly.
  }

  void billingaddressbutton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Listitempage()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      ),
      body: Column(
        children: [
          const Headertext(text: 'Start Selling'),
          const MyContainer(
            headerText: "Add your Billing Address",
            text: "We need this info for you to be a seller",
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    UnderlineTextField(
                      controller: unitnumber,
                      hintText: 'Enter your Unit No.',
                      labelText: 'Unit No.',
                      obscureText: false,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: UnderlineTextField(
                        controller: addressline1,
                        hintText: 'Enter your Address',
                        labelText: 'Address Line 1',
                        obscureText: false,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                      ),
                    ),
                    UnderlineTextField(
                      controller: addressline2,
                      hintText: 'Enter your 2nd Address',
                      labelText: 'Address Line 2 (optional)',
                      obscureText: false,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: UnderlineTextField(
                        controller: city,
                        hintText: 'Enter your City',
                        labelText: 'City',
                        obscureText: false,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                      ),
                    ),
                    UnderlineTextField(
                      controller: stateprovince,
                      hintText: 'Enter your State, Province, or Region',
                      labelText: 'State, province or region',
                      obscureText: false,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: UnderlineTextField(
                        controller: postalcode,
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
                          builder: (context) => ListOfCountryPage(),
                        ))
                            .then((selectedData) async {
                          if (selectedData != null) {
                            setState(() {
                              selectedCountry = selectedData;
                            });
                          }
                        });
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
                                  padding: EdgeInsets.all(15.0),
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
                        onTap: () {
                          if (!isNameEmpty) {
                            billingaddressbutton(context);
                          }
                        },
                        isDisabled:
                            isNameEmpty, // Pass the isNameEmpty variable here
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
