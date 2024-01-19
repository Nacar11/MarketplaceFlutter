// ignore_for_file: unused_import,, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/controllers/OrderLineController.dart';
import 'package:marketplacedb/controllers/products/ProductItemController.dart';
import 'package:marketplacedb/data/models/OrderLineModel.dart';
import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/mepagesettings.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/selling.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

UserController userController = UserController.instance;

class Mepage extends StatefulWidget {
  const Mepage({Key? key}) : super(key: key);
  @override
  State<Mepage> createState() => MepageState();
}

class MepageState extends State<Mepage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        endDrawer: const MePageSettings(),
        body: Column(
          children: [
            Container(
              height: MPSizes.sm / 2,
              color: Colors.grey,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.all(MPSizes.md),
                  child: Container(child: const Icon(Iconsax.user))),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: TabBar(
                controller:
                    _tabController, // You'll need to define _tabController
                tabs: const [
                  Tab(text: 'Selling'),
                  Tab(text: 'Orders'),
                  Tab(text: 'Saved'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  FirstOptionMenu(),
                  SecondOptionMenu(),
                  Text('Test')
                ],
              ),
            ),
          ],
        ));
  }
}

class CircularProfilePicture extends StatelessWidget {
  final AssetImage imageAsset;

  const CircularProfilePicture({required this.imageAsset, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0, // Adjust the size as needed
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue, // Border color
          width: 2.0, // Border width
        ),
      ),
      child: ClipOval(
        child: Image(image: imageAsset, fit: BoxFit.cover),
      ),
    );
  }
}

class FirstOptionMenu extends StatefulWidget {
  const FirstOptionMenu({Key? key}) : super(key: key);
  @override
  State<FirstOptionMenu> createState() => _FirstOptionMenuState();
}

class _FirstOptionMenuState extends State<FirstOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(color: MPColors.accent));
  }
}

class SecondOptionMenu extends StatefulWidget {
  const SecondOptionMenu({Key? key}) : super(key: key);
  @override
  State<SecondOptionMenu> createState() => _SecondOptionMenuState();
}

class _SecondOptionMenuState extends State<SecondOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(color: MPColors.black));
  }
}
