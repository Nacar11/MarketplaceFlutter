import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/texts/section_headings.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/signin_pages/settings_pages/profle_page/profile_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

UserController userController = UserController.instance;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimarySearchAppBar(
            actions: null,
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Profile",
                  style: Theme.of(context).textTheme.headlineMedium),
            ])),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(MPSizes.defaultSpace),
                child: Column(children: [
                  const Center(
                    child: MPRoundedImage(
                      hasBorder: true,
                      applyImageRadius: true,
                      imageUrl: MPImages.femaleCategoryIcon,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture')),
                  const SizedBox(height: MPSizes.spaceBtwItems / 2),
                  const Divider(),
                  const SizedBox(height: MPSizes.spaceBtwItems),
                  const MPSectionHeading(
                    title: "Profile Information",
                  ),
                  const SizedBox(height: MPSizes.spaceBtwSections),
                  ProfileMenu(
                      title: 'Name',
                      value:
                          '${userController.userData.value.firstName} ${userController.userData.value.lastName}',
                      onPressed: () {}),
                  ProfileMenu(
                      title: 'Username',
                      value: userController.userData.value.username!,
                      onPressed: () {}),
                  const SizedBox(height: MPSizes.spaceBtwItems / 2),
                  const Divider(),
                  const SizedBox(height: MPSizes.spaceBtwItems),
                  const MPSectionHeading(
                    title: "Personal Information",
                  ),
                  const SizedBox(height: MPSizes.spaceBtwSections),
                  ProfileMenu(
                      title: 'Email',
                      value: userController.userData.value.email!,
                      onPressed: () {}),
                  ProfileMenu(
                      title: 'Date of Birth',
                      value: userController.userData.value.birthDate!,
                      onPressed: () {}),
                  ProfileMenu(
                      title: 'Gender',
                      value: userController.userData.value.gender!,
                      onPressed: () {}),
                  ProfileMenu(
                      title: 'Phone Number',
                      value: userController.userData.value.contactNumber!,
                      onPressed: () {}),
                ]))));
  }
}
