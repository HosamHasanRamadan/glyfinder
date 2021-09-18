import 'package:riverpod/riverpod.dart';

import '../configure_dependencies.dart';
import '../services/logger.dart';
import '../stores/font_icons_pacakges_store.dart';
import 'get_font_icons_packages.dart';
import 'icon_commnds/load_fonts.dart';

final bootstrabProvider = StreamProvider((ref) async* {
  final logger = getIt<Logger>();

  logger.i('bootstraping....');

  yield 'Loading All Icons....';
  final packages = await GetFontIconsPacakges().call();
  ref.read(fontIconsPackagesStoreProvider).init(packages);

  yield 'Loading All Fonts...';
  await LoadFonts().call(packages);

  yield 'Done';
  logger.i('bootstraping ✅');

  await Future<void>.delayed(const Duration(seconds: 1));
});
