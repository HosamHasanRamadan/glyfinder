import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glyfinder/data/font_icon.dart';

final fontIconsStoreProvider =
    ChangeNotifierProvider((ref) => FontIconsStore());

class FontIconsStore extends ValueNotifier<List<FontIcon>> {
  FontIconsStore() : super([]);

  void init(Iterable<FontIcon> fontIcons) {
    value = List.from(fontIcons);
  }

  void like(FontIcon fontIcon) {
    value = value
        .map((element) => element.id == fontIcon.id
            ? element.copyWith(isLiked: true)
            : element)
        .toList();
  }

  void unLike(FontIcon fontIcon) {
    value = value
        .map((element) => element.id == fontIcon.id
            ? element.copyWith(isLiked: false)
            : element)
        .toList();
  }
}
