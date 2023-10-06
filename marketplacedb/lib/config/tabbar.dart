// import 'package:flutter/material.dart';
// import 'package:marketplacedb/config/expansiontile.dart';
// import 'package:marketplacedb/config/textfields.dart';
// import 'package:marketplacedb/config/buttons.dart';
// import 'package:marketplacedb/screen/signin_pages/sellpage_pages/billingaddress.dart';

// class Tabbar extends StatefulWidget {
//   final TabController tabController;
//   const Tabbar({Key? key, required this.tabController}) : super(key: key);

//   @override
//   // ignore: no_logic_in_create_state
//   State<Tabbar> createState() => TabbarState(tabController: tabController);
// }

// class TabbarState extends State<Tabbar> {
//   final TabController tabController;

//   TabbarState({required this.tabController});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // const SizedBox(height: 20),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black, width: 2.0),
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10.0),
//                 topRight: Radius.circular(10.0),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: 10.0), // Add padding to make space for the border
//               child: TabBar(
//                 controller: tabController,
//                 tabs: const [
//                   Tab(text: 'Manage'),
//                   Tab(text: 'How it Works'),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: tabController,
//               children: [
//                 ListView(children: const [
//                   FirstOptionMenu(),
//                 ]), // Content for the "Manage" tab
//                 const SecondOptionMenu(), // Content for the "How it Works" tab
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TabBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(0, size.height);
//     path.lineTo(0, size.height - 10.0); // Adjust the value as needed
//     path.quadraticBezierTo(size.width / 2, size.height, size.width,
//         size.height - 10.0); // Adjust the value as needed
//     path.lineTo(size.width, size.height);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// class FirstOptionMenu extends StatefulWidget {
//   const FirstOptionMenu({Key? key}) : super(key: key);
//   @override
//   State<FirstOptionMenu> createState() => _FirstOptionMenuState();
// }

// class _FirstOptionMenuState extends State<FirstOptionMenu> {
//   void listItemButton(BuildContext context) {
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => const BillingAddress()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//       Expantiontile(
//           key: UniqueKey(),
//           titleText: 'All sold Items'), // Call the Expantiontile widget here
//       Expantiontile(key: UniqueKey(), titleText: 'Drafts'),
//       Expantiontile(key: UniqueKey(), titleText: 'Offers'),
//       Expantiontile(key: UniqueKey(), titleText: 'Discounts'),
//       Container(
//         height: 5,
//         color: Colors.grey,
//       ),
//       Column(
//         children: [
//           const Align(
//             alignment: Alignment.centerLeft, // Align the header to the right
//             child: Headertext(text: 'Shop Settings'),
//           ),
//           Expantiontile(key: UniqueKey(), titleText: 'Vacation Mode'),
//           Expantiontile(key: UniqueKey(), titleText: 'Bundles'),
//           Expantiontile(key: UniqueKey(), titleText: 'Policies'),
//           Expantiontile(key: UniqueKey(), titleText: 'Share'),
//           Expantiontile(key: UniqueKey(), titleText: 'Sold Item Issues'),
//         ],
//       ),
//       ListItem(onTap: () {
//         listItemButton(context);
//       }),
//     ]);
//   }
// }

// class SecondOptionMenu extends StatelessWidget {
//   const SecondOptionMenu({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ListTile(
//           title: Text(
//             '1. List an Item',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             'Describe your item and add photos. Set a competitive price and reach millions of shoppers.',
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//         SizedBox(height: 20),
//         ListTile(
//           title: Text(
//             '2. Ship the Item',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             'We provide a prepaid shipping label for easy and insured shipping. You can also choose to ship it yourself.',
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//         SizedBox(height: 20),
//         ListTile(
//           title: Text(
//             '3. Get Paid',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             'Receive up to 90% of your sale when the item is delivered to your buyer.',
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//         // Add your specific widgets for Option 2 here
//       ],
//     );
//   }
// }
