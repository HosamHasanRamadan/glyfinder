import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glyfinder/data/font_icons_package.dart';

final fontIconsPackagesStoreProvider =
    ChangeNotifierProvider((ref) => FontIconsPackagesStore());

class FontIconsPackagesStore extends ValueNotifier<List<FontIconsPackage>> {
  FontIconsPackagesStore() : super([]);

  FontIconsPackage getFont(String packageName) {
    return value.firstWhere((element) => element.packageName == packageName);
  }

  void init(Iterable<FontIconsPackage> fontIconsPackages) {
    value = [...fontIconsPackages];
  }

  void addAll(Iterable<FontIconsPackage> fontIconsPackages) {
    value = [...value, ...fontIconsPackages];
  }
}
