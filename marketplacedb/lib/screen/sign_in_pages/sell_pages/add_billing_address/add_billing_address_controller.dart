import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/data/models/addresses/city_model.dart';
import 'package:marketplacedb/data/models/addresses/country_model.dart';
import 'package:marketplacedb/data/models/addresses/region_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/address_list_page/address_list_controller.dart';
import 'dart:convert';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:marketplacedb/util/popups/full_screen_overlay_loader.dart';

class AddBillingAddressController extends GetxController {
  static AddBillingAddressController get instance => Get.find();
  final isLoading = false.obs;
  MPLocalStorage localStorage = MPLocalStorage();
  final countryList = <CountryModel>[].obs;
  final regionList = <RegionModel>[].obs;
  final cityList = <CityModel>[].obs;
  final selectedCountry = CountryModel().obs;
  final selectedRegion = RegionModel().obs;
  final selectedCity = CityModel().obs;

//TEXT-EDITING CONTROLLERS
  final unitNumber = TextEditingController();
  final addressLine1 = TextEditingController();
  final addressLine2 = TextEditingController();
  final postalCode = TextEditingController();
  final phoneNumber = ''.obs;
  final isPhoneValid = false.obs;
  GlobalKey<FormState> unitNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> addressLine1Key = GlobalKey<FormState>();
  GlobalKey<FormState> postalCodeKey = GlobalKey<FormState>();
  final isUnitNumberValid = false.obs;
  final isAddressLine1Valid = false.obs;
  final isPostalCodeValid = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCountries();
  }

  Future<void> addBillingAddress() async {
    try {
      isLoading.value = true;
      // for (var entry in billingAddressData.entries) {
      //   print('${entry.key}: ${entry.value}');
      // }
      MPFullScreenOverlayLoader.openLoadingDialog();
      final response = await AuthInterceptor().post(
        Uri.parse("${url}addAddress"),
        body: {
          "contact_number": phoneNumber.value,
          "unit_number": unitNumber.text,
          "address_line_1": addressLine1.text,
          "address_line_2": addressLine2.text,
          "city_id": selectedCity.value.id.toString(),
          "region_id": selectedRegion.value.id.toString(),
          "postal_code": postalCode.text,
          "country_id": selectedCountry.value.id.toString(),
        },
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        isLoading.value = false;

        if (localStorage.readData('addAddressToNavigation') == true) {
          MPFullScreenOverlayLoader.stopLoading();
          Get.offAll(() => const Navigation());
        } else {
          AddressListPageController addressListPageController =
              AddressListPageController.instance;

          await addressListPageController.getUserAddresses();
          MPFullScreenOverlayLoader.stopLoading();
          Get.back();
        }

        getSnackBar('Address Successfully Added', "Successful", true);
      } else {
        MPFullScreenOverlayLoader.stopLoading();
        isLoading.value = false;
        getSnackBar(
            'Error on Adding User Address, Please Try Again.', 'error', false);
        throw Exception('message is not success');
      }
    } catch (e) {
      MPFullScreenOverlayLoader.stopLoading();
      isLoading.value = false;
      getSnackBar(
          'Error on Adding User Address, Please Try Again.', 'error', false);
      print('Error in fetching data: $e');
    }
  }

  Future<void> onCountrySelected(CountryModel country) async {
    selectedCountry.value = country;

    regionList.value = countryList
        .firstWhere((c) => c.id == selectedCountry.value.id)
        .regions!;

    selectedRegion.value = RegionModel();
    selectedCity.value = CityModel();
    cityList.value = <CityModel>[];
  }

  Future<void> onRegionSelected(RegionModel region) async {
    selectedRegion.value = region;

    cityList.value =
        regionList.firstWhere((c) => c.id == selectedRegion.value.id).cities!;

    selectedCity.value = CityModel();
  }

  Future<void> onCitySelected(CityModel city) async {
    selectedCity.value = city;
  }

  Future<void> getCountries() async {
    isLoading.value = true;
    try {
      final response =
          await AuthInterceptor().get(Uri.parse("${url}countries"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<CountryModel> list =
            result.map((e) => CountryModel.fromJson(e)).toList();
        countryList.assignAll(list);
        print(countryList.length);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('message is not success');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error in fetching data: $e');
    }
  }

  Future<void> getRegionsByCountryId(int countryId) async {
    isLoading.value = true;
    try {
      final response = await AuthInterceptor()
          .get(Uri.parse("${url}getRegionsByCountryId/$countryId"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<RegionModel> list =
            result.map((e) => RegionModel.fromJson(e)).toList();
        regionList.assignAll(list);
        print(regionList.length);
        print(regionList);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('message is not success');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error in fetching data: $e');
    }
  }
}
