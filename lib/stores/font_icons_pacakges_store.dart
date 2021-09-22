import 'package:flutter/foundation.dart';

import '../data/font_icons_package.dart';

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
