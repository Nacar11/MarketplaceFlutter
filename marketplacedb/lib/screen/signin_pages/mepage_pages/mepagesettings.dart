// ignore_for_file: avoid_print, unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/screen/front_page.dart';
import 'package:marketplacedb/config/snackbar.dart';

// import 'package:get/get.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class Mepagesettings extends StatefulWidget {
  const Mepagesettings({Key? key}) : super(key: key);

  @override
  State<Mepagesettings> createState() => MepagesettingsState();
}

final authController = AuthenticationController();

class MepagesettingsState extends State<Mepagesettings> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
              accountName: Text('FnameLname'), accountEmail: Text('email.com')),
          ListTile(
            title: TextButton(
              onPressed: () async {
                // final storage = GetStorage();
                // print('ASD ${storage.read('token')}'); //
                // await storage.erase();

                var response = await authController.logout();
                if (response['message'] == 'Logged out Successfully') {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Frontpage(logoutMessage: true),
                  ));
                } else {
                  showErrorHandlingSnackBar(
                    context,
                    'Error Logging Out, Please Try Again',
                    'error',
                  );
                }
              },
              child: const Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
