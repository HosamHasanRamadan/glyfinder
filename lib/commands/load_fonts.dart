import '../configure_dependencies.dart';
import '../data/font_icons_package.dart';
import '../services/font_service.dart';
import '../services/logger.dart';

class LoadFonts {
  late final Logger _logger;
  late final FontService _fontService;

  LoadFonts() {
    _logger = getIt<Logger>();
    _fontService = getIt<FontService>();
  }

  Future<bool> call(List<FontIconsPackage> fontIconspackages) async {
    _logger.i('Loading Fonts....');
    for (var font in fontIconspackages) {
      _logger.d('Loading ${font.packageName} \n${font.fontUrl}');
      await _fontService.loadFont(font.packageName, font.fontUrl.toString());
      _logger.d('Loaded ${font.packageName}');
    }
    _logger.i('Fonts Loaded');
    return true;
  }
}
