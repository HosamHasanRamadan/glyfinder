import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glyfinder/services/font_icons_api.dart';
import 'package:glyfinder/services/logger.dart';
import 'package:glyfinder/stores/font_icons_pacakges_store.dart';

final getFontIconsPacakgesProvider =
    Provider((ref) => GetFontIconsPacakges(ref.read));

class GetFontIconsPacakges {
  late final Command _command;
  Command get command => _command;

  GetFontIconsPacakges(Reader read) {
    _command = Command.createAsyncNoParamNoResult(() async {
      final service = read(fontIconsApiProvider);
      final logger = read(loggerProvider);

      logger.i('getting font icons pacakges');
      final fontIconsPackagesStore = read(fontIconsPackagesStoreProvider);
      try {
        final fontIconsPackages = await service.getAllFontIconsPackages();
        fontIconsPackagesStore.init(fontIconsPackages);
        logger.i('getting font icons pacakges ✅');
      } on Exception {
        logger.e('error while loading icons packages');
      }
    });
  }
}
