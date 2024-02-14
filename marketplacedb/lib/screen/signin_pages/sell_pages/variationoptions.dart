import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/controllers/products/product_Controller.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/data/models/VariantsOptionsModel.dart';

final controller = Get.put<ProductController>(ProductController());

class VariationOptionsPage extends StatefulWidget {
  final List<VariationOptionModel> options;
  final String variant;
  final int selectedIndex;
  const VariationOptionsPage(
      {Key? key,
      required this.selectedIndex,
      required this.options,
      required this.variant})
      : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<VariationOptionsPage> createState() =>
      // ignore: no_logic_in_create_state
      VariationOptionsPageState(
          selectedIndex: selectedIndex, options: options, variant: variant);
}

class VariationOptionsPageState extends State<VariationOptionsPage> {
  final List<VariationOptionModel> options;
  final String variant;
  final int selectedIndex;
  final productController = ProductController();
  VariationOptionsPageState(
      {required this.selectedIndex,
      required this.options,
      required this.variant});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.variant,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        body: Column(
          children: [
            for (final option in options)
              ExpansiontileButton(
                  text: (option.value ?? "Error on Handling API Responses"),
                  onTap: () {
                    // print(option.id);
                    Navigator.of(context).pop(option);
                  }),
          ],
        ));
  }
}
