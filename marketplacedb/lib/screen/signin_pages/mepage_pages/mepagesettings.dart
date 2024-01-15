// ignore_for_file: avoid_print, unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/screen/front_page.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';

// import 'package:get/get.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class Mepagesettings extends StatefulWidget {
  const Mepagesettings({Key? key}) : super(key: key);

  @override
  State<Mepagesettings> createState() => MepagesettingsState();
}

final authController = AuthenticationController();
MPLocalStorage localStorage = MPLocalStorage();

class MepagesettingsState extends State<Mepagesettings> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
              accountName: Text('TBD'), accountEmail: Text('TBD')),
          ListTile(
            title: TextButton(
              onPressed: () async {
                print('ASD ${localStorage.readData('token')}'); //

                await authController.logout(context);
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
