import 'package:flutter/material.dart';

/// A ListView layout with customizable separator, padding, and margin.
class MPListViewLayout extends StatelessWidget {
  const MPListViewLayout({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  /// The number of items in the list.
  final int itemCount;

  /// A builder function that creates a widget for each item in the list.
  final Widget Function(BuildContext, int) itemBuilder;

  /// A builder function that creates a widget for the separator between adjacent items.
  final Widget Function(BuildContext, int)? separatorBuilder;

  /// The padding around the list.
  final EdgeInsets padding;

  /// The margin around the list.
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ListView.separated(
        separatorBuilder: separatorBuilder ?? (_, __) => const SizedBox(),
        itemCount: itemCount,
        shrinkWrap: true,
        padding: padding,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: itemBuilder,
      ),
    );
  }
}
