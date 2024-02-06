// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/sell_page/sell_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class SellPage extends StatelessWidget {
  const SellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          MPPrimaryHeaderContainer(
            child: Column(children: [
              MPSellPageAppBar(
                showBackArrow: false,
              ),
              SizedBox(height: MPSizes.spaceBtwSections),
            ]),
          ),
        ]),
      ),
    );
  }
}
