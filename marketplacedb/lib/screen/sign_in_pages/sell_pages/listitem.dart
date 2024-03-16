// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:permission_handler/permission_handler.dart';
// import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
// import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
// import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
// // import 'package:marketplacedb/constants/constant.dart';
// // import 'package:marketplacedb/models/ProductCategoryModel.dart';
// import 'package:marketplacedb/data/models/products/product_type_model.dart';
// import 'package:marketplacedb/data/models/variation_option_model.dart';
// import 'package:marketplacedb/controllers/products/VariationController.dart';
// import 'package:marketplacedb/controllers/products/product_item_controller.dart';
// import 'package:marketplacedb/data/models/variation_model.dart';
// import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
// // import 'package:marketplacedb/models/VariantsOptionsModel.dart';
// import 'package:marketplacedb/screen/signin_pages/sell_pages/categorylist.dart';
// import 'package:marketplacedb/screen/signin_pages/sell_pages/variationoptions.dart';
// import 'dart:io';
// import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';

// final variationController = VariationController();
// final productItemController = ProductItemController();

// class Listitempage extends StatefulWidget {
//   final String? hasSnackbar;
//   const Listitempage({Key? key, this.hasSnackbar}) : super(key: key);

//   @override
//   State<Listitempage> createState() =>
//       // ignore: no_logic_in_create_state
//       ListitempageState(hasSnackbar: hasSnackbar ?? '');
// }

// class ListitempageState extends State<Listitempage>
//     with SingleTickerProviderStateMixin {
//   final String? hasSnackbar;
//   ListitempageState({required this.hasSnackbar});

//   late TabController _tabController;

//   ProductTypeModel? productTypeSelected;
//   late List<VariationModel> variations = [];
//   List<String> variationOptionSelectedList = [];
//   Map<int, VariationOptionModel> selectedOptions = {};
//   Map<String, TextEditingController> myControllers = {
//     'price': TextEditingController(),
//     'description': TextEditingController(),
//     'productType': TextEditingController(),
//   };
//   List<File?> selectedImages = List.filled(4, null);
//   // int indeximage;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();

//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     // variationController.dispose();
//     // productTypeController.dispose();
//     // descriptionController.dispose();
//     // priceController.dispose();
//     // _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> fetchData() async {
//     await variationController.getVariantsByProductType(
//       int.parse(myControllers['productType']!.text),
//     );

//     for (var variation in variationController.variationList) {
//       for (var option in variation.variationOptions!) {
//         print(option.value);
//       }
//     }
//   }

//   Future<void> _displayBottomSheet(BuildContext context, int index) async {
//     await showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           height: 200,
//           padding: const EdgeInsets.all(40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       pickImage(index, ImageSource.camera);
//                       // Implement the action for "Take a Photo" here
//                       Navigator.pop(context); // Close the bottom sheet
//                     },
//                     child: const Text("Take a Photo"),
//                   ),
//                 ],
//               ),
//               // Add spacing between the buttons
//               Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     pickImage(index, ImageSource.gallery);
//                     Navigator.pop(context); // Close the bottom sheet
//                   },
//                   child: const Text("Pick Image from Gallery"),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//     selectedImages.asMap().forEach((index, image) {
//       print('Image $index: $image');
//     });
//   }

//   // File? _selectedImage;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => const Navigation(),
//               ));
//             },
//           ),
//           title: const Center(
//             child: Row(
//               mainAxisAlignment:
//                   MainAxisAlignment.center, // Center the children horizontally
//               children: [
//                 Text('Listing', style: TextStyle(fontSize: 30)),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.auto_awesome_motion_outlined),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//         body: Column(children: [
//           Container(
//             height: 1, // Adjust the height to make the line thicker
//             color: Colors.grey, // Adjust the color as needed
//           ),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(4, (index) {
//                   return GestureDetector(
//                     onTap: () {
//                       _displayBottomSheet(context, index);
//                     },
//                     child: SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: selectedImages[index] != null
//                           ? Image.file(selectedImages[index]!)
//                           : InkWell(
//                               // Use InkWell for tap gestures
//                               onTap: () {
//                                 _displayBottomSheet(context, index);
//                               },
//                               child: const Icon(
//                                   Icons.camera_alt), // Use the Icon widget
//                             ),
//                     ),
//                   );
//                 }),
//               )),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 25),
//             child: Container(
//               decoration: const BoxDecoration(
//                 border: Border(
//                   top:
//                       BorderSide(color: Colors.black, width: 3.0), // Top border
//                   bottom: BorderSide(
//                       color: Colors.black, width: 3.0), // Bottom border
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: TabBar(
//                   controller:
//                       _tabController, // You'll need to define _tabController
//                   tabs: const [
//                     Tab(text: 'Info'),
//                     Tab(text: 'Attributes'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: TabBarView(controller: _tabController, children: [
//               ListView(
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       ExpansiontileButton(
//                         text: productTypeSelected?.name ?? "Selected Product",
//                         onTap: () {
//                           Navigator.of(context)
//                               .push(
//                             MaterialPageRoute(
//                               builder: (context) => const CategoryListPage(),
//                             ),
//                           )
//                               .then((selectedData) async {
//                             if (selectedData != null) {
//                               setState(() {
//                                 myControllers['productType']!.text =
//                                     selectedData.id.toString();
//                                 productTypeSelected = selectedData;
//                                 fetchData();
//                                 variationOptionSelectedList = List.filled(
//                                     variations.length, 'InitialValue');
//                                 selectedOptions = {};
//                               });
//                             }
//                           });
//                         },
//                       ),
//                       UnderlineTextField(
//                         controller: myControllers['description']!,
//                         hintText: 'Enter Description',
//                         labelText: 'Enter Description',
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 16.0),
//                       ),
//                       UnderlineTextField(
//                         controller: myControllers['price']!,
//                         hintText: 'Item Price',
//                         labelText: 'Enter Price',
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 16.0),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 100.0),
//                     child: Row(children: [
//                       const LargeWhiteButton(
//                         onPressed: null,
//                         text: 'Save to Drafts',
//                         margin: EdgeInsets.symmetric(horizontal: 40),
//                       ),
//                       LargeWhiteButton(
//                         margin: const EdgeInsets.only(right: 30),
//                         onPressed: () async {
//                           selectedOptions.forEach((key, value) {
//                             print('Key: $key, Value: ${value.value}');
//                           });
//                           var response =
//                               await productItemController.imageUpload(
//                                   selectedImages,
//                                   myControllers,
//                                   selectedOptions);
//                           if (response == 1) {
//                             // Navigator.of(context).pushReplacement(
//                             //     MaterialPageRoute(
//                             //         builder: (context) => const Navigation(
//                             //             hasSnackbar: 'listingAdded')));
//                           } else {
//                             // errorSnackBar(
//                             //     context,
//                             //     "Adding Item Failed, Please Try Again.",
//                             //     'error');
//                           }
//                         },
//                         isDisabled: productItemController.isLoading.value,
//                         text: 'Post Listing',
//                       )
//                     ]),
//                   ),
//                 ], // Content for the "Manage" tab
//               ),
//               Obx(() {
//                 return variationController.isLoading.value == true
//                     ? const Center(
//                         child: CircularProgressIndicator(
//                           strokeWidth: 4.0,
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.blue),
//                         ),
//                       )
//                     : ListView(children: [
//                         if (variationController.variationList.isNotEmpty)
//                           Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 30,
//                                 horizontal: 20,
//                               ),
//                               child: Column(
//                                 children: variationController.variationList
//                                     .asMap()
//                                     .entries
//                                     .map((entry) {
//                                   final int index = entry.key;
//                                   final VariationModel variation = entry.value;
//                                   return Row(
//                                     children: [
//                                       Expanded(
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 10.0),
//                                           child: Text(
//                                             variation.name!,
//                                             style: const TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Column(
//                                         children: [
//                                           ExpansiontileButton(
//                                             text:
//                                                 selectedOptions[index]?.value ??
//                                                     "Select an Option",
//                                             onTap: () {
//                                               Navigator.of(context)
//                                                   .push(MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     VariationOptionsPage(
//                                                   options: variation
//                                                       .variationOptions!,
//                                                   variant: variation.name!,
//                                                   selectedIndex:
//                                                       index, // Pass the index
//                                                 ),
//                                               ))
//                                                   .then((selectedData) async {
//                                                 if (selectedData != null) {
//                                                   setState(() {
//                                                     selectedOptions[index] =
//                                                         selectedData;
//                                                   });
//                                                 }
//                                               });
//                                             },
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   );
//                                 }).toList(),
//                               ))
//                         else
//                           const Padding(
//                             padding: EdgeInsets.symmetric(vertical: 20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ListTile(
//                                   title: Text(
//                                     'NO PRODUCT TYPE LISTED',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   subtitle: Text(
//                                     'Please select a product type to view additional information',
//                                     style: TextStyle(fontSize: 16),
//                                   ),
//                                 ),

//                                 // Add your specific widgets for Option 2 here
//                               ],
//                             ),
//                           ),
//                       ]);
//               })
//             ]),
//           )
//         ]));
//   }

//   Future<void> pickImage(int index, ImageSource source) async {
//     try {
//       final pickedFile = await ImagePicker().pickImage(source: source);
//       if (pickedFile != null) {
//         setState(() {
//           selectedImages[index] = File(pickedFile.path);
//           print(selectedImages[index]);
//           print('asd');
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
// }
