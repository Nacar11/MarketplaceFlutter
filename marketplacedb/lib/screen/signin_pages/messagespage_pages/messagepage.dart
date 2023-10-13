import 'package:flutter/material.dart';

import 'package:marketplacedb/controllers/userController.dart';

class Messagepage extends StatefulWidget {
  const Messagepage({Key? key}) : super(key: key);

  @override
  State<Messagepage> createState() => MessagepageState();
}

final userController = UserController();

class MessagepageState extends State<Messagepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Stack(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 8.0), // Add space above the text
                child: Text('Messages', style: TextStyle(fontSize: 30)),
              ),
            ),
            Positioned(
              right: -15, // Adjust the right position as needed
              child: IconButton(
                icon: const Icon(Icons
                    .filter_alt_outlined), // Replace 'your_icon_here' with the desired icon
                onPressed: () {
                  // Add your icon's action here
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0), // Add padding to make space for the border
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Chat'),
                    Tab(text: 'Offers'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(children: const [
                  FirstOptionMenu(),
                ]), // Content for the "Manage" tab
                const SecondOptionMenu(), // Content for the "How it Works" tab
              ],
            ),
          ),
        ],
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
  // void goToListAnItem(BuildContext context) {
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const Listitempage()));
  // }

  // void goToBillingAddress(BuildContext context) {
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const BillingAddress()));
  // }

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

        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: ListTile(
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
        ),

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
