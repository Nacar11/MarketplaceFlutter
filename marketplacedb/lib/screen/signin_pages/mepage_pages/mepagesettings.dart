// ignore_for_file: avoid_print, unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/landing_pages/front_page.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';

// import 'package:get/get.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

UserController userController = UserController.instance;
MPLocalStorage localStorage = MPLocalStorage();

class MePageSettings extends StatelessWidget {
  const MePageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Obx(
            () {
              return UserAccountsDrawerHeader(
                accountName: Text(userController.userData.value.username ?? ''),
                accountEmail: Text(userController.userData.value.email ?? ''),
              );
            },
          ),
          ListTile(
            title: TextButton(
              onPressed: () async {
                print('ASD ${localStorage.readData('token')}');
                await userController.logout(context);
              },
              child: Text("Log Out",
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
        ],
      ),
    );
  }
}
