// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:marketplacedb/screen/front_page.dart';

// import 'package:get/get.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Mepagesettings extends StatefulWidget {
  const Mepagesettings({Key? key}) : super(key: key);

  @override
  State<Mepagesettings> createState() => MepagesettingsState();
}

final authController = AuthenticationController();

class MepagesettingsState extends State<Mepagesettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close), // Use the close icon (X)
              onPressed: () {
                // Handle the action when the X button is pressed
                Navigator.of(context)
                    .pop(); // Typically, this would navigate back
              },
            ),
            const Text('Settings', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 4, // Adjust the height to make the line thicker
            color: Colors.grey, // Adjust the color as needed
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align to the start
            children: [
              TextButton(
                onPressed: () async {
                  var response = await authController.logout();
                  if (response['message'] == 'Logged out Successfully') {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Frontpage()));
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    print('ASD ${prefs.getString('token')}');
                    await prefs.clear();
                    print(prefs.getString('token'));
                  } else {
                    final snackbar = SnackBar(
                      duration: const Duration(seconds: 3),
                      content: const Text('Error, Please Try Again!'),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.black, // Customize the text color
                    fontSize: 20, // Customize the font size
                    // Add underline
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 4, // Adjust the height to make the line thicker
            color: Colors.grey, // Adjust the color as needed
          ),
        ],
      ),
    );
  }
}
