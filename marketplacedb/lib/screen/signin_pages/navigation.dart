import 'package:flutter/material.dart';
import 'package:marketplacedb/config/icons.dart';
import 'package:marketplacedb/screen/signin_pages/homepage.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int index = 0;
  final screens = [
    const Homepage(),
    const Discoverpage(),
    const Sellpage(),
    //Messages(),
    //Me(),
  ];

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
