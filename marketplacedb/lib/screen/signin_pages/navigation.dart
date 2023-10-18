// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:marketplacedb/config/icons.dart';
import 'package:marketplacedb/screen/signin_pages/homepage.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/discoverpage.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/sellpage.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/mepage.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/snackbar.dart';
import 'package:flutter/services.dart';
import 'package:marketplacedb/screen/signin_pages/messagespage_pages/messagepage.dart';

class Navigation extends StatefulWidget {
  final String? hasSnackbar;

  const Navigation({Key? key, this.hasSnackbar}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<Navigation> createState() =>
      // ignore: no_logic_in_create_state
      NavigationState(hasSnackbar: hasSnackbar ?? '');
}

class NavigationState extends State<Navigation> {
  final String? hasSnackbar;
  final productController = ProductController();
  NavigationState({required this.hasSnackbar});

  int index = 0;
  final screens = [
    const Homepage(),
    const Discoverpage(),
    const Sellpage(),
    const Messagepage(),
    const Mepage(),
  ];

  @override
  void initState() {
    super.initState();
    final storage = GetStorage();
    print(storage.read('token'));
    if (hasSnackbar != '') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        switch (hasSnackbar) {
          case 'welcomeMessage':
            showWelcomeMessageSnackBar();
            break;
          case 'listingAdded':
            showSuccessSnackBar(
                context, 'Your Product has been Listed!', 'Success');
            break;
          default:
        }
      });
    }
  }

  void showWelcomeMessageSnackBar() {
    final storage = GetStorage();
    String text = 'Welcome, ${storage.read('username')}';
    showSuccessSnackBar(context, text, 'loginsuccess');
  }

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle the back button press here
          SystemNavigator
              .pop(); // This will exit the app and go to the home screen
          return false; // Return false to prevent exiting the app immediately
        },
        child: SafeArea(
            child: Scaffold(
          bottomNavigationBar: NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: const [
                NavigationDestination(icon: PentagonIcon(), label: 'home'),
                NavigationDestination(
                    icon: Icon(Icons.search), label: 'Discover'),
                NavigationDestination(icon: Icon(Icons.home), label: 'Sell'),
                NavigationDestination(
                    icon: Icon(Icons.mail), label: 'Messages'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Me'),
              ]),
          //
          body: screens[index],
        )));
  }
}
