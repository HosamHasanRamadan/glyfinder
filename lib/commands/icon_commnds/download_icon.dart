import 'package:url_launcher/url_launcher.dart';

import '../../data/font_icon.dart';

class DownloadIcon {
  void call(FontIcon fontIcon) {
    launch(fontIcon.svgUrl.toString());
  }
}
