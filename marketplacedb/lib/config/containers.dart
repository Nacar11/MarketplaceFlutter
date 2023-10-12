import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class CardItem {
  final String urlImage;

  const CardItem({
    required this.urlImage,
  });
}

// Future<void> _displayBottomSheet(BuildContext context) {
//   return showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//             height: 200,
//           ));
// }

class MyContainer extends StatelessWidget {
  const MyContainer({Key? key, required this.headerText, required this.text})
      : super(key: key);
  final String headerText; // Parameter for header text
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 202, 189, 189),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText, // Display the header text
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
              height: 40), // Add some spacing between header and main text
          Text(
            text, // Display the main text content
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class Homepagecon extends StatefulWidget {
  const Homepagecon({Key? key}) : super(key: key);

  @override
  State<Homepagecon> createState() => HomepageconState();
}

class HomepageconState extends State<Homepagecon> {
  List<CardItem> items = [
    const CardItem(urlImage: 'flutter_images/shirt1.jpg'),
    const CardItem(urlImage: 'flutter_images/shirt2.jpg'),
    const CardItem(urlImage: 'flutter_images/jeans1.jpg'),
    const CardItem(urlImage: 'flutter_images/shirt1.jpg'),
    const CardItem(urlImage: 'flutter_images/shirt2.jpg'),
    const CardItem(urlImage: 'flutter_images/jeans1.jpg'),
    const CardItem(urlImage: 'flutter_images/shirt1.jpg'),
    const CardItem(urlImage: 'flutter_images/shirt2.jpg'),
    const CardItem(urlImage: 'flutter_images/jeans1.jpg'),
    const CardItem(urlImage: 'flutter_images/jeans1.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 256,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (context, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => buildCard(item: items[index]),
      ),
    );
  }
}

class Womenswear extends StatefulWidget {
  const Womenswear({Key? key}) : super(key: key);

  @override
  State<Womenswear> createState() => WomenswearState();
}

class WomenswearState extends State<Womenswear> {
  List<CardItem> items = [
    const CardItem(urlImage: 'flutter_images/women1.jpg'),
    const CardItem(urlImage: 'flutter_images/women2.jpg'),
    const CardItem(urlImage: 'flutter_images/women3.jpg'),
    const CardItem(urlImage: 'flutter_images/women1.jpg'),
    const CardItem(urlImage: 'flutter_images/women2.jpg'),
    const CardItem(urlImage: 'flutter_images/women3.jpg'),
    const CardItem(urlImage: 'flutter_images/women1.jpg'),
    const CardItem(urlImage: 'flutter_images/women2.jpg'),
    const CardItem(urlImage: 'flutter_images/women3.jpg'),
    const CardItem(urlImage: 'flutter_images/women1.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 256,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (context, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => buildCard(item: items[index]),
      ),
    );
  }
}

Widget buildCard({
  required CardItem item,
}) =>
    SizedBox(
      width: 200,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              item.urlImage,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );

class DashedBorderContainerWithIcon extends StatelessWidget {
  final Function()? onTap;
  final File? selectedImage;
  const DashedBorderContainerWithIcon(
      {required this.selectedImage,
      required this.onTap,
      required this.iconData,
      Key? key})
      : super(key: key);
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // () {
      //   print('asd');
      // },
      child: SizedBox(
        width: 80, // Set the desired width
        height: 80, // Set the desired height
        child: Container(
          padding: const EdgeInsets.all(20), // Padding of the outer Container
          child: DottedBorder(
            color: Colors.black, // Color of dotted/dash line
            strokeWidth: 1, // Thickness of dash/dots
            dashPattern: const [
              5,
              5
            ], // Dash patterns, 10 is dash width, 6 is space width
            child: Center(
              child: Icon(
                iconData, // Replace with your desired icon
                size: 30, // Adjust the size of the icon as needed
                color: Colors.grey, // Set the color of the icon
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  const ProductContainer({required this.text, required this.fontsize, Key? key})
      : super(key: key);
  final String text;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, // Adjust the border color
          width: 3.0, // Adjust the border width
        ),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown, // Scale the text down to fit the container
          child: Text(
            text,
            style: TextStyle(fontSize: fontsize),
          ),
        ),
      ),
    );
  }
}
