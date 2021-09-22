import 'package:flutter/foundation.dart';

import 'package:flutter_command/flutter_command.dart';
import 'package:url_launcher/url_launcher.dart';

import '../commands/icon_commnds/like_icon.dart';
import '../commands/icon_commnds/unlike_icon.dart';
import '../data/font_icon.dart';

class FontIconsStore extends ValueNotifier<List<FontIcon>> {
  late final Command<FontIcon, void> like;
  late final Command<FontIcon, void> unLike;
  late final Command<FontIcon, void> downloadIcon;

  FontIconsStore([List<FontIcon>? initalValue]) : super(initalValue ?? []) {
    like = Command.createAsyncNoResult((fontIcon) async {
      await LikeIcon().call(fontIcon);

      final newValue = value
          .map((element) => element.id == fontIcon.id
              ? element.copyWith(isLiked: true)
              : element)
          .toList();
      value = List.from(newValue);
    });

    unLike = Command.createAsyncNoResult((fontIcon) async {
      await UnLikeIcon().call(fontIcon);
      final newValue = value.map((element) => element.id == fontIcon.id
          ? element.copyWith(isLiked: false)
          : element);
      value = List.from(newValue);
    });

    downloadIcon = Command.createSyncNoResult((fontIcon) {
      launch(fontIcon.svgUrl.toString());
    });
  }

  void init(Iterable<FontIcon> fontIcons) {
    value = List.from(fontIcons);
  }
}
