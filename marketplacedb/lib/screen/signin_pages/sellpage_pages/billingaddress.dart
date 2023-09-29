import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_birthdate.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class BillingAddress extends StatefulWidget {
  const BillingAddress({Key? key}) : super(key: key);

  @override
  State<BillingAddress> createState() => BillingAddressState();
}

class BillingAddressState extends State<BillingAddress> {
  final addressline1 = TextEditingController();
  final addressline2 = TextEditingController();
  final city = TextEditingController();
  final stateprovince = TextEditingController();
  final postalcode = TextEditingController();
  final country = TextEditingController();
  final authController = AuthenticationController();

  bool isNameEmpty = true;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field and update isNameEmpty accordingly.
  }

  void continuebutton(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPagebirthdate()));
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
                    const SizedBox(height: 20),
                    UnderlineTextField(
                      controller: addressline1,
                      hintText: 'Enter your Address',
                      labelText: 'Address Line 1',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    UnderlineTextField(
                      controller: addressline2,
                      hintText: 'Enter your 2nd Address',
                      labelText: 'Address Line 2 (optional)',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    UnderlineTextField(
                      controller: city,
                      hintText: 'Enter your City',
                      labelText: 'City',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    UnderlineTextField(
                      controller: stateprovince,
                      hintText: 'Enter your State, Province, or Region',
                      labelText: 'State, province or region',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    UnderlineTextField(
                      controller: postalcode,
                      hintText: 'Enter your Zip or Postal Code',
                      labelText: 'Zip or Postal Code',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    UnderlineTextField(
                      controller: country,
                      hintText: 'Enter your Country',
                      labelText: 'Country',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
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
