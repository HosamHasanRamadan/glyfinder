import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/font_icons_package.dart';

final fontIconsPackagesStoreProvider =
    ChangeNotifierProvider((ref) => FontIconsPackagesStore());

class FontIconsPackagesStore extends ValueNotifier<List<FontIconsPackage>> {
  FontIconsPackagesStore([List<FontIconsPackage>? initialValue])
      : super(initialValue ?? []);

  void init(List<FontIconsPackage> fontIconsPackages) {
    value = fontIconsPackages;
  }

  FontIconsPackage getFont(String packageName) {
    return value.firstWhere((element) => element.packageName == packageName);
  }

  void addAll(Iterable<FontIconsPackage> fontIconsPackages) {
    value = [...value, ...fontIconsPackages];
  }
}
