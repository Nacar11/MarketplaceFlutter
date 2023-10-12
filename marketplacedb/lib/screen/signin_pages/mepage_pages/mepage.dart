import 'package:flutter/material.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/mepagesettings.dart';
import 'package:marketplacedb/controllers/userController.dart';
// import 'package:marketplacedb/config/textfields.dart';

class Mepage extends StatefulWidget {
  const Mepage({Key? key}) : super(key: key);

  @override
  State<Mepage> createState() => MepageState();
}

final userController = UserController();

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
        endDrawer: const Mepagesettings(),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 4, // Adjust the height to make the line thicker
              color: Colors.grey, // Adjust the color as needed
            ),
            const SizedBox(height: 10),
            const Row(children: [
              SizedBox(width: 20), // Add some space on the left
              CircularProfilePicture(
                imageAsset: AssetImage('flutter_images/batman.png'),
              ),
              SizedBox(width: 20),
            ]), // Add space between profile picture and other content
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TabBar(
                  controller:
                      _tabController, // You'll need to define _tabController
                  tabs: const [
                    Tab(text: 'Selling'),
                    Tab(text: 'Likes'),
                    Tab(text: 'Saved'),
                  ],
                ),
              ),
            ),
          ],
        ));
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
    return const Column(
        mainAxisAlignment: MainAxisAlignment.start, children: []);
  }
}

class SecondOptionMenu extends StatelessWidget {
  const SecondOptionMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            '1. List an Item',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Describe your item and add photos. Set a competitive price and reach millions of shoppers.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text(
            '2. Ship the Item',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'We provide a prepaid shipping label for easy and insured shipping. You can also choose to ship it yourself.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text(
            '3. Get Paid',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Receive up to 90% of your sale when the item is delivered to your buyer.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        // Add your specific widgets for Option 2 here
      ],
    );
  }
}

class ThirdOptionMenu extends StatefulWidget {
  const ThirdOptionMenu({Key? key}) : super(key: key);
  @override
  State<ThirdOptionMenu> createState() => _ThirdOptionMenuState();
}

class _ThirdOptionMenuState extends State<ThirdOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.start, children: []);
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
