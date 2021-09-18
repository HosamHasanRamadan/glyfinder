import '../configure_dependencies.dart';
import '../data/font_icons_package.dart';
import '../services/font_icons_api.dart';
import '../services/logger.dart';

class GetFontIconsPacakges {
  late final FontIconsApi _fontIconsApi;
  late final Logger _logger;

  GetFontIconsPacakges() {
    _fontIconsApi = getIt<FontIconsApi>();
    _logger = getIt<Logger>();
  }
  Future<List<FontIconsPackage>> call() async {
    _logger.i('getting font icons pacakges');
    try {
      final fontIconsPackages = await _fontIconsApi.getAllFontIconsPackages();
      _logger.i('getting font icons pacakges ✅');
      return fontIconsPackages;
    } on Exception {
      _logger.e('error while loading icons packages');
      throw UnimplementedError();
    }
  }
}
