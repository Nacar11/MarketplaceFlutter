import 'package:flutter/material.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/categorylist.dart';

class Listitempage extends StatefulWidget {
  const Listitempage({
    Key? key,
  }) : super(key: key);

  @override
  State<Listitempage> createState() => ListitempageState();
}

class ListitempageState extends State<Listitempage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ProductCategoryModel? productCategorySelected;

  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    categoryController
        .dispose(); // Dispose the controller when the widget is removed
    descriptionController.dispose();
    priceController.dispose();
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
          const SizedBox(height: 30), //padding
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
          const SizedBox(height: 30),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black, width: 3.0), // Top border
                bottom: BorderSide(
                    color: Colors.black, width: 3.0), // Bottom border
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
                ListView(children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Card(
                      elevation: 2, // Customize the card elevation as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Add your button's action here
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => const CategoryListPage(),
                            ),
                          )
                              .then((selectedData) {
                            if (selectedData != null) {
                              setState(() {
                                print(selectedData);
                                categoryController.text =
                                    selectedData.id.toString();
                                print(categoryController.text);
                                productCategorySelected = selectedData;
                              });
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                productCategorySelected?.category_name ??
                                    "Selected Product",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.expand_more),
                            ],
                          ),
                        ),
                      ),
                    ),
                    UnderlineTextField(
                      controller: descriptionController,
                      hintText: 'Enter Description',
                      labelText: 'Enter Description',
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                    ),
                    UnderlineTextField(
                      controller: priceController,
                      hintText: 'Item Price',
                      labelText: 'Enter Price',
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                    ),
                  ])
                ]), // Content for the "Manage" tab
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                ) // Content for the "How it Works" tab
              ],
            ),
          ),
          const Row(children: [
            LargeWhiteButton(onPressed: null, text: 'Save to Drafts'),
            LargeBlackButton(
              onPressed: null,
              text: 'Post Listing',
              fontsize: 20,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 0),
            )
          ]),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// class FirstOptionMenu extends StatefulWidget {
//   final List<ProductCategoryModel>? productCategorySelected;
//   const FirstOptionMenu({Key? key, this.productCategorySelected})
//       : super(key: key);

//   @override
//   State<FirstOptionMenu> createState() => _FirstOptionMenuState();
// }

// final pricecontroller = TextEditingController();
// final descriptioncontroller = TextEditingController();

// class _FirstOptionMenuState extends State<FirstOptionMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

// class SecondOptionMenu extends StatelessWidget {
//   const SecondOptionMenu({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return const ;
//   }
// }

// const ExpansionTile(
//         title: Text("condition"),
//       ),
//       const ExpansionTile(
//         title: Text("Brand"),
//       ),
//       const ExpansionTile(
//         title: Text("Size"),
//       ),
//       const ExpansionTile(
//         title: Text("Color"),
//       ),
//update
