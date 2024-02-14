import 'package:get/get.dart';
import 'package:marketplacedb/data/models/CityModel.dart';
import 'package:marketplacedb/data/models/CountryModel.dart';
import 'package:marketplacedb/data/models/RegionModel.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'dart:convert';
import 'package:marketplacedb/util/constants/app_constant.dart';

class AddBillingAddressController extends GetxController {
  static AddBillingAddressController get instance => Get.find();

  final index = 0.obs;
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

  Future<void> onCountrySelected(CountryModel country) async {
    print('called onCountry function');
    selectedCountry.value = country;

    regionList.value = countryList
        .firstWhere((c) => c.id == selectedCountry.value.id)
        .regions!;

    print(regionList[0].name);
    print('-----------------------');
    selectedRegion.value = RegionModel();
    selectedCity.value = CityModel();
    cityList.value = <CityModel>[];
  }

  Future<void> onRegionSelected(RegionModel region) async {
    print('called onRegion function');
    selectedRegion.value = region;

    cityList.value =
        regionList.firstWhere((c) => c.id == selectedRegion.value.id).cities!;

    print(cityList[0].name);
    print('-----------------------');
    selectedCity.value = CityModel();
  }

  Future<void> onCitySelected(CityModel city) async {
    print('called onCityfunction');
    selectedCity.value = city;

    print(selectedCity.value.name);
    print('-----------------------');
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
