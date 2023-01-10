import 'package:hive/hive.dart';

class HiveService {
  HiveService();

  Future<void> storeData({
    required String boxName,
    required Map<String, dynamic> data,
  }) async {
    await Hive.openBox('user');
    final box = Hive.box(boxName);
    for (MapEntry<String, dynamic> entry in data.entries.toList()) {
      box.put(
        entry.key,
        entry.value,
      );
    }
  }

  Future<Map<String, dynamic>>

      /// Getting data from the box.
      getData(
    String boxName,
    List<String> keys,
  ) async {
    await Hive.openBox('user');
    final box = Hive.box(boxName);
    Map<String, dynamic> map = {};
    for (String key in keys) {
      map = {
        key: box.get(key),
      };
    }
    return map;
  }
}
