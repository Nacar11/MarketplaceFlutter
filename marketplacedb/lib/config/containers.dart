import 'package:flutter/material.dart';

class CardItem {
  final String urlImage;

  const CardItem({
    required this.urlImage,
  });
}

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
