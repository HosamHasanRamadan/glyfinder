import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glyfinder/data/font_icon.dart';
import 'package:glyfinder/local_storage/liked_icons_storage.dart';
import 'package:glyfinder/services/font_icons_api.dart';
import 'package:glyfinder/stores/font_icon_store.dart';
import 'package:glyfinder/views/pages/icons_search_page.dart';

final searhForIconsProvider = Provider((ref) => SearchForIcons(ref.read));

class SearchForIcons {
  late final Command<SearchForIconsParam, void> _command;
  Command get command => _command;

  SearchForIcons(Reader read) {
    _command = Command.createAsyncNoResult<SearchForIconsParam>((param) async {
      final fontsIconsStore = read(fontIconsStoreProvider);

      final iconsResult = await compute(_searchFor, param.searchValue);

      final likeIcons = (await read(likedIconsStorageProvider.future)).getAll();

      fontsIconsStore.init(iconsResult
          .map((e) => likeIcons.contains(e) ? e.copyWith(isLiked: true) : e));
      Navigator.of(param.context).push(
        MaterialPageRoute(
          builder: (_) {
            return IconsSearchPage(
              fontIcons: iconsResult,
              searchValue: param.searchValue,
            );
          },
        ),
      );
    });
  }
}

Future<List<FontIcon>> _searchFor(String value) async {
  return FontIconsApi().getIconsMatch(value);
}

class SearchForIconsParam {
  final String searchValue;
  final BuildContext context;

  const SearchForIconsParam({
    required this.searchValue,
    required this.context,
  });
}
