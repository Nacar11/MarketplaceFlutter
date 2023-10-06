import 'package:flutter/material.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
// import 'package:marketplacedb/config/tabbar.dart';
// import 'package:marketplacedb/config/buttons.dart';
// import 'package:marketplacedb/screen/signin_pages/sellpage_pages/billingaddress.dart';
// import 'package:marketplacedb/config/expansiontile.dart';
// import 'package:marketplacedb/config/textfields.dart';

class Listitempage extends StatefulWidget {
  const Listitempage({Key? key}) : super(key: key);

  @override
  State<Listitempage> createState() => ListitempageState();
}

class ListitempageState extends State<Listitempage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final descriptioncontroller = TextEditingController();

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
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the children horizontally
            children: [
              Text('Listing', style: TextStyle(fontSize: 30)),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.auto_awesome_motion_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 1, // Adjust the height to make the line thicker
            color: Colors.grey, // Adjust the color as needed
          ),
          const SizedBox(height: 30),
          const Row(children: [
            DashedBorderContainerWithIcon(iconData: Icons.camera_alt),
            DashedBorderContainerWithIcon(iconData: Icons.camera_alt),
            DashedBorderContainerWithIcon(iconData: Icons.camera_alt),
            DashedBorderContainerWithIcon(iconData: Icons.camera_alt),
            DashedBorderContainerWithIcon(iconData: Icons.videocam),
          ]),
          const Sidetext(
            text: 'Read our shooting tips',
            onPressed: null,
            textcolor: Colors.blue,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Headertext(text: 'Description'),
            ],
          ),
          UnderlineTextField(
            controller: descriptioncontroller,
            hintText: 'Enter Description',
            labelText: 'Enter Description',
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          ),
          const SizedBox(height: 30),
          Container(
            height: 5, // Adjust the height to make the line thicker
            color: Colors.grey, // Adjust the color as needed
          ),
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
                  Tab(text: 'Info'),
                  Tab(text: 'Attributes'),
                ],
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

final pricecontroller = TextEditingController();

class _FirstOptionMenuState extends State<FirstOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const ExpansionTile(
        title: Text("Category"),
      ),
      const ExpansionTile(
        title: Text("condition"),
      ),
      const ExpansionTile(
        title: Text("Brand"),
      ),
      const ExpansionTile(
        title: Text("Size"),
      ),
      const ExpansionTile(
        title: Text("Color"),
      ),
      UnderlineTextField(
        controller: pricecontroller,
        hintText: 'Item Price',
        labelText: 'Enter Price',
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      ),
    ]);
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
