import 'package:flutter_command/flutter_command.dart';
import 'package:riverpod/riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:glyfinder/data/font_icon.dart';

final downloadIconProvider = Provider((ref) => DownloadIcon(ref.read));

class DownloadIcon {
  late final Command<FontIcon, void> _commnad;
  Command get command => _commnad;

  DownloadIcon(Reader ref) {
    _commnad = Command.createSyncNoResult((fontIcon) {
      launch(fontIcon.svgUrl.toString());
    });
  }
}
