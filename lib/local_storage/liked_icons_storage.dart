import 'dart:async';

import 'package:hive/hive.dart';

import '../data/font_icon.dart';

class LikedIconsStorage {
  static const storeId = 'likes';
  final Box<String> _box;

  LikedIconsStorage._(this._box);

  static Future<LikedIconsStorage> open() async {
    final box = await Hive.openBox<String>(storeId);
    return LikedIconsStorage._(box);
  }

  Stream<Iterable<FontIcon>> get stream => _box.watch().map(
        (event) => _box.values.map(
          (fontIconJson) => FontIcon.fromJson(fontIconJson),
        ),
      );

  Future<void> add(FontIcon fontIcon) async {
    await _box.put(fontIcon.id, fontIcon.toJson());
  }

  Future<void> delete(FontIcon fontIcon) async {
    await _box.delete(fontIcon.id);
  }

  Iterable<FontIcon> getAll() {
    return _box.values
        .map((fontIconJsonString) => FontIcon.fromJson(fontIconJsonString));
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
