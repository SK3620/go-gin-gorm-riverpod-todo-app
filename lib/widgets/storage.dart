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

//SecureStorageクラスで使用しているセキュアストレージはiosの場合、キーチェーンで保存んされており、
// 初回起動時判定には使わない。
class WalkThroughCheckSharedPreference {
  save(callback, String key, bool data) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(key, data).then((value) => callback());
  }

  load(tokenCallback, String key) async {
    final prefs = await SharedPreferences.getInstance();

    final bool repeat = prefs.getBool(key) ?? false;

    //tokenがない場合はnull
    tokenCallback(repeat);
  }
}

class SharedPreference {
  save(callback, String key, int data) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(key, data).then((value) => callback());
  }

  load(callback, String key) async {
    final prefs = await SharedPreferences.getInstance();

    final int? repeat = prefs.getInt(key);

    callback(repeat);
  }
}
//
// String? options;
// CustomerOptionsResponse? optionsModel;
//
// class OptionsSharedPreference {
//   save(String key, String data) async {
//     options = data;
//
//     var responseObject = jsonDecode(data);
//
//     optionsModel = CustomerOptionsResponse.fromJson(responseObject);
//
//     final prefs = await SharedPreferences.getInstance();
//
//     await prefs.setString(key, data);
//   }
//
//   load(callback, String key) async {
//     String data;
//
//     if (optionsModel == null) {
//       if (options == null) {
//         final prefs = await SharedPreferences.getInstance();
//
//         final String repeat = prefs.getString(key) ?? "";
//
//         data = repeat;
//       } else {
//         data = options!;
//       }
//
//       var optionsObject = jsonDecode(data);
//
//       CustomerOptionsResponse optionsResponse = CustomerOptionsResponse.fromJson(optionsObject);
//
//       callback(optionsResponse);
//     } else {
//       callback(optionsModel);
//     }
//   }
// }
