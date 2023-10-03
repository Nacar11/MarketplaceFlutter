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
        body: ListView(
          children: [
            Column(children: [
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
                  textcolor: Colors.blue)
            ]),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Headertext(text: 'Info'),
              ],
            ),
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
              controller: descriptioncontroller,
              hintText: 'Item Price',
              labelText: 'Enter Price',
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            ),
            const SizedBox(height: 30),
            Container(
              height: 5, // Adjust the height to make the line thicker
              color: Colors.grey, // Adjust the color as needed
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Headertext(text: 'Shipping'),
              ],
            ),
            const ExpansionTile(
              title: Text("Shipping Fee"),
            ),
            const ExpansionTile(
              title: Text("Location"),
            ),
          ],
        ));
  }
}
