import 'package:flutter/material.dart';
// import 'package:marketplacedb/config/icons.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/CustomAppBar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  int index = 0;

  // @override
  // Widget build(BuildContext context) => Scaffold(
  //       bottomNavigationBar: NavigationBar(
  //         destinations: [
  //           NavigationDestination(icon: PentagonIcon(), label: 'home')
  //         ],
  //       ),
  //     );

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomappBar(),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 3, // Adjust the height to make the line thicker
                  color: Colors.grey, // Adjust the color as needed
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Headertext(text: 'Suggested for you'),
                    ),
                    // Sidetext(text: 'see more'),
                  ],
                ),
              ],
            ),
            const Homepagecon(),
            const Headertext(text: 'Recommended Sellers'),
            const Homepagecon(),
            const Homepagecon(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Headertext(text: 'Our Picks'),
                ),
                // Sidetext(text: 'see more'),
              ],
            ),
            const Homepagecon(),
            const Homepagecon(),
            const Homepagecon(),
            const Homepagecon(),
          ],
        ),
      ),
    );
  }
}
