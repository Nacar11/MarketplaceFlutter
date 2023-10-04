import 'package:flutter/material.dart';
import 'package:marketplacedb/config/icons.dart';
import 'package:marketplacedb/screen/signin_pages/homepage.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/discoverpage.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/sellpage.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/mepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marketplacedb/controllers/productController.dart';

class Navigation extends StatefulWidget {
  final bool? welcomeMessage;

  const Navigation({Key? key, this.welcomeMessage}) : super(key: key);
  @override
  State<Navigation> createState() =>
      // ignore: no_logic_in_create_state
      NavigationState(welcomeMessage: welcomeMessage ?? false);
}

class NavigationState extends State<Navigation> {
  final bool welcomeMessage;
  final productController = ProductController();
  NavigationState({required this.welcomeMessage});

  int index = 0;
  final screens = [
    const Homepage(),
    const Discoverpage(),
    const Sellpage(),
    //Messages(),
    const Mepage(),
  ];

  @override
  void initState() {
    super.initState(); // Call the superclass's initState
    // Call your custom init method here
    init();
  }

  Future init() async {
    final prefs = await SharedPreferences.getInstance();
    await productController.getProductCategories();
    if (widget.welcomeMessage == true) {
      final snackbar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('Welcome, ${prefs.getString('username')}'),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(icon: PentagonIcon(), label: 'home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Discover'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Sell'),
            NavigationDestination(icon: Icon(Icons.mail), label: 'Messages'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Me'),
          ]),
      //
      body: screens[index],
    ));
  }
}
