import 'package:flutter/material.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/mepagesettings.dart';
import 'package:marketplacedb/controllers/userController.dart';
// import 'package:marketplacedb/config/textfields.dart';

class Mepage extends StatefulWidget {
  const Mepage({Key? key}) : super(key: key);

  @override
  State<Mepage> createState() => MepageState();
}

final userController = UserController();

class MepageState extends State<Mepage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        endDrawer: const Mepagesettings(),
        body: Column(
          children: [
            Container(
              height: 4, // Adjust the height to make the line thicker
              color: Colors.grey, // Adjust the color as needed
            ),

            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                // Add some space on the left
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                  child: CircularProfilePicture(
                    imageAsset: AssetImage('flutter_images/batman.png'),
                  ),
                ),
              ]),
            ), // Add space between profile picture and other content

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TabBar(
                    controller:
                        _tabController, // You'll need to define _tabController
                    tabs: const [
                      Tab(text: 'Selling'),
                      Tab(text: 'Likes'),
                      Tab(text: 'Saved'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class CircularProfilePicture extends StatelessWidget {
  final AssetImage imageAsset;

  const CircularProfilePicture({required this.imageAsset, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0, // Adjust the size as needed
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue, // Border color
          width: 2.0, // Border width
        ),
      ),
      child: ClipOval(
        child: Image(image: imageAsset, fit: BoxFit.cover),
      ),
    );
  }
}
