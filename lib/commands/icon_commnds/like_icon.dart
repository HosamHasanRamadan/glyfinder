import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glyfinder/data/font_icon.dart';
import 'package:glyfinder/local_storage/liked_icons_storage.dart';
import 'package:glyfinder/stores/font_icon_store.dart';

final likeIconProvider = Provider((ref) => LikeIcon(ref.read));

class LikeIcon {
  late final Command<FontIcon, void> _command;
  Command get command => _command;
  LikeIcon(Reader read) {
    _command = Command.createAsyncNoResult<FontIcon>((fontIcon) async {
      final likedIconsStorage = await read(likedIconsStorageProvider.future);
      final fontIconStore = read(fontIconsStoreProvider);
      fontIconStore.like(fontIcon);
      await likedIconsStorage.add(fontIcon.copyWith(isLiked: true));
    });
  }
}
