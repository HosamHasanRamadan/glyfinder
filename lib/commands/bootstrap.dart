import '../configure_dependencies.dart';
import '../services/logger.dart';
import '../stores/font_icons_pacakges_store.dart';
import 'get_font_icons_packages.dart';
import 'load_fonts.dart';

class Bootstrap {
  Stream<String> call() async* {
    final logger = getIt<Logger>();

    logger.i('bootstraping....');

    yield 'Loading All Icons....';
    final packages = await GetFontIconsPacakges().call();
    getIt<FontIconsPackagesStore>().init(packages);

    yield 'Loading All Fonts...';
    await LoadFonts().call(packages);

    yield 'Done';
    logger.i('bootstraping ✅');
  }
}
