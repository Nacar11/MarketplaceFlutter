import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/data/models/addresses/city_model.dart';
import 'package:marketplacedb/data/models/addresses/country_model.dart';
import 'package:marketplacedb/data/models/addresses/region_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'dart:convert';
import 'package:marketplacedb/util/constants/app_constant.dart';

class AddBillingAddressController extends GetxController {
  static AddBillingAddressController get instance => Get.find();
  final isLoading = false.obs;
  final countryList = <CountryModel>[].obs;
  final regionList = <RegionModel>[].obs;
  final cityList = <CityModel>[].obs;
  final selectedCountry = CountryModel().obs;
  final selectedRegion = RegionModel().obs;
  final selectedCity = CityModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getCountries();
  }

  Future<void> addBillingAddress(Map<String, String> billingAddressData) async {
    isLoading.value = true;
    try {
      // for (var entry in billingAddressData.entries) {
      //   print('${entry.key}: ${entry.value}');
      // }
      final response = await AuthInterceptor().post(
        Uri.parse("${url}addAddress"),
        body: billingAddressData,
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        isLoading.value = false;
        Get.offAll(() => const Navigation());
        getSnackBar('Address Successfully Added', "Successful", true);
      } else {
        isLoading.value = false;
        getSnackBar(
            'Error on Adding User Address, Please Try Again.', 'error', false);
        throw Exception('message is not success');
      }
    } catch (e) {
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
