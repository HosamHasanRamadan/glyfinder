import 'package:dynamic_cached_fonts/dynamic_cached_fonts.dart';

class FontService {
  FontService();

  Future<void> loadFont(String fontFamily, String fontUrl) async {
    final dynmaicCache = DynamicCachedFonts(
      url: fontUrl,
      fontFamily: fontFamily,
    );
    await dynmaicCache.load();
  }

  Future<void> loadFonts(Map<String, String> fontFmailyToUrl) async {
    for (var fontFamily in fontFmailyToUrl.keys) {
      await loadFont(fontFamily, fontFmailyToUrl[fontFamily]!);
    }
  }
}
