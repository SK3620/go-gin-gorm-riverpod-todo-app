import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  save(String key, String data) async {
    await storage.write(key: key, value: data);
  }

  Future<String> load(String key) async {
    //tokenがない場合はnull
    return (await storage.read(key: key) ?? "");
  }

  delete(String key) async {
    //tokenがない場合はnull
    await storage.write(key: key, value: "");
  }

  Future<String> getValue(String key) async {
    var value = await storage.read(key: key) ?? "";
    return value;
  }
}