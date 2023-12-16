import 'package:flutter/material.dart';

class MarketplaceLogo extends StatelessWidget {
  final double width;
  final double height;
  const MarketplaceLogo({
    this.width = 100,
    this.height = 100,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      width: width,
      height: height,
      image: const AssetImage('flutter_images/mp.png'),
      fit: BoxFit.contain,
    );
  }
}
