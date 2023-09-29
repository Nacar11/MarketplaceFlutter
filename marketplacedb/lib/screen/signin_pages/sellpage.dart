import 'package:flutter/material.dart';
import 'package:marketplacedb/config/tabbar.dart';
// import 'package:marketplacedb/config/buttons.dart';

class Sellpage extends StatefulWidget {
  const Sellpage({Key? key}) : super(key: key);

  @override
  State<Sellpage> createState() => SellpageState();
}

class SellpageState extends State<Sellpage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(130.0), // Adjust the height as needed
        child: Column(
          children: [
            const SizedBox(height: 20), // SizedBox above the AppBar
            AppBar(
              flexibleSpace: const Stack(
                alignment: Alignment.topLeft,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('flutter_images/batman.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Tabbar(tabController: _tabController),
    );
  }
}
