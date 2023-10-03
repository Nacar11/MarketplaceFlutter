import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/mepagesettings.dart';

class Mepage extends StatefulWidget {
  const Mepage({Key? key}) : super(key: key);

  @override
  State<Mepage> createState() => MepageState();
}

class MepageState extends State<Mepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications, size: 40),
              onPressed: () {
                // Handle the search button action
              },
            ),
            const Spacer(), // Creates space between the buttons
            IconButton(
              icon: const Icon(Icons.assignment_outlined, size: 40),
              onPressed: () {
                // Handle the settings button action
              },
            ),
            const Spacer(), // Creates space between the buttons
            IconButton(
              icon: const Icon(Icons.settings, size: 40),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Mepagesettings()),
                );
              },
            ),
          ],
        ),
        body: Column(children: [
          const SizedBox(height: 10),
          Container(
            height: 4, // Adjust the height to make the line thicker
            color: Colors.grey, // Adjust the color as needed
          ),
        ]));
  }
}
