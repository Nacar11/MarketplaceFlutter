import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key, required this.title, required this.value});

  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: MPSizes.spaceBtwItems / 1.5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.7),
                overflow: TextOverflow.ellipsis)),
        const SizedBox(height: MPSizes.sm),
        Text(value,
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis),
      ]),
    );
  }
}
