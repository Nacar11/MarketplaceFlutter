import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/list_tile.dart';
import 'package:marketplacedb/common/widgets/texts/section_headings.dart';
import 'package:marketplacedb/screen/signin_pages/settings_pages/account_settings_page/account_settings_page_widgets.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

UserController userController = UserController.instance;

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);
  @override
  State<AccountSettingsPage> createState() => AccountSettingsPageState();
}

class AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      MPPrimaryHeaderContainer(
          child: Column(children: [
        MPSettingsAppBar(),
        MPUserProfileTile(),
        SizedBox(height: MPSizes.spaceBtwSections),
      ])),
      Padding(
          padding: EdgeInsets.all(MPSizes.defaultSpace),
          child: Column(children: [
            MPSectionHeading(title: "Account Settings"),
            SizedBox(height: MPSizes.spaceBtwItems)
          ]))
    ])));
  }
}
