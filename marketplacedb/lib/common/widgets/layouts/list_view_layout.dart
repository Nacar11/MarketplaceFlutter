import 'package:flutter/material.dart';

class MPListViewLayout extends StatelessWidget {
  const MPListViewLayout({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final EdgeInsets padding;
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
