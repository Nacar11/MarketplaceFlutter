import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/controllers/user/user_controller.dart';

UserController userController = UserController.instance;

class MPSettingsAppBar extends StatelessWidget {
  const MPSettingsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PrimarySearchAppBar(
      showBackArrow: false,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Account", style: Theme.of(context).textTheme.headlineMedium),
      ]),
      actions: const [],
    );
  }
}
