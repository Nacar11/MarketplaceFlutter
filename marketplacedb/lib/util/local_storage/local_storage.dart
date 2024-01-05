import 'package:get_storage/get_storage.dart';

class MPLocalStorage {
  static final MPLocalStorage _instance = MPLocalStorage._internal();

  factory MPLocalStorage() {
    return _instance;
  }

  MPLocalStorage._internal();

  static Future<void> init() async {
    await GetStorage.init(); // Initialize GetStorage
  }

  final _storage = GetStorage();

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
