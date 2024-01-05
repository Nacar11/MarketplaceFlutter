import 'package:flutter/material.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

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
      image: const AssetImage(ImagesUtils.appLogo),
      fit: BoxFit.contain,
    );
  }
}

class GetStartedUpperText extends StatelessWidget
    implements PreferredSizeWidget {
  const GetStartedUpperText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Text(
          'Get Started',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TermsOfServicesContainer extends StatelessWidget {
  const TermsOfServicesContainer({Key? key, required this.bottomSheetHeight})
      : super(key: key);
  final double bottomSheetHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: bottomSheetHeight,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Marketplace',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const SizedBox(height: 30),
            const Text(
              'Marketplace\'s Privacy Policy does not apply to other advertisers or websites. Thus, we advise you to consult the respective Privacy Policies of these third-party ad servers for more detailed information, which may include their practices and instructions about how to opt-out of certain options.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            const Text(
              'CCPA Privacy Rights (Do Not Sell My Personal Information)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'Under the CCPA, among other rights, California consumers have the right to request that a business collecting their personal data disclose the categories and specific pieces of personal data collected. They can also request the deletion of their personal data collected by a business and can opt-out of the sale of their personal data. If you wish to exercise any of these rights, please contact us. We have one month to respond to your request.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            const Text(
              'GDPR Data Protection Rights',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'We aim to ensure that you are fully aware of your data protection rights. Every user is entitled to the following:\n\n'
              '- The right to access: You can request copies of your personal data. A small fee may be charged for this service.\n'
              '- The right to rectification: You can request corrections for any information you believe is inaccurate or incomplete.\n'
              '- The right to erasure: You can request the deletion of your personal data under certain conditions.\n'
              '- The right to restrict processing: You can request restrictions on the processing of your personal data under certain conditions.\n'
              '- The right to object to processing: You can object to our processing of your personal data under certain conditions.\n'
              '- The right to data portability: You can request the transfer of your collected data to another organization or directly to you under certain conditions.\n'
              'If you wish to exercise any of these rights, please contact us. We have one month to respond to your request.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            const Text(
              'Children\'s Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'We prioritize adding protection for children using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.\n\n'
              'Thriftsample Store does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you believe that your child provided this kind of information on our website, please contact us immediately. We will do our best efforts to promptly remove such information from our records.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            const Text(
              'Changes to This Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'We may update our Privacy Policy periodically. We advise you to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after being posted.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            const Text(
              'Contact Us',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerGuide extends StatelessWidget {
  const ContainerGuide({
    Key? key,
    required this.headerText,
    this.text,
    this.richText,
  }) : super(key: key);

  final String headerText;
  final String? text;
  final RichText? richText;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MPHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.all(MPSizes.defaultSpace),
      decoration: BoxDecoration(
        color: isDarkMode ? MPColors.darkContainer : MPColors.lightContainer,
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
          Text(headerText, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: MPSizes.spaceBtwSections), // Add some spacing

          if (richText != null)
            richText!
          else if (text != null)
            Text(text!, style: Theme.of(context).textTheme.bodyLarge),
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

class CardItem {
  final String urlImage;

  const CardItem({
    required this.urlImage,
  });
}
