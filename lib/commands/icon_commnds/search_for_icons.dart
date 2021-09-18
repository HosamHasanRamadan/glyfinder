import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../configure_dependencies.dart';
import '../../data/font_icon.dart';
import '../../local_storage/liked_icons_storage.dart';
import '../../services/font_icons_api.dart';

class SearchForIcons {
  late final LikedIconsStorage _likedIconsStorage;

  SearchForIcons() {
    _likedIconsStorage = getIt<LikedIconsStorage>();
  }

  Future<List<FontIcon>> call(String value) async {
    final iconsResult = await compute(_searchFor, value);
    final likedIcons = _likedIconsStorage.getAll();
    return iconsResult
        .map((e) => likedIcons.contains(e) ? e.copyWith(isLiked: true) : e)
        .toList();
  }
}

Future<List<FontIcon>> _searchFor(String value) async {
  // register again because this code runs in different thread
  // because web doesn't support @compute yet don't re-register deps because it is already registered
  if (!kIsWeb) await configureDependencies(isUiThread: false);

  return getIt<FontIconsApi>().getIconsMatch(value);
}
