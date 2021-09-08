import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'package:glyfinder/services/font_service.dart';
import 'package:glyfinder/services/logger.dart';
import 'package:glyfinder/stores/font_icons_pacakges_store.dart';

final loadFontsProvider = Provider((ref) => LoadFonts(ref.read));

class LoadFonts {
  late final Command<void, void> _command;
  Command get command => _command;

  LoadFonts(Reader read) {
    _command = Command.createAsyncNoParamNoResult(() async {
      final logger = read(loggerProvider);
      final fontService = read(fontServiceProvider);
      final fontIconsPackagesStore = read(fontIconsPackagesStoreProvider);

      logger.i('Loading Fonts....');
      for (var font in fontIconsPackagesStore.value) {
        logger.d('Loading ${font.packageName} \n${font.fontUrl}');
        await fontService.loadFont(font.packageName, font.fontUrl.toString());
        logger.d('Loaded ${font.packageName}');
      }
      logger.i('Fonts Loaded');
    });
  }
}
