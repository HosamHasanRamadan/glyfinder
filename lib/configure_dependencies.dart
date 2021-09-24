import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'local_storage/liked_icons_storage.dart';
import 'services/font_icons_api.dart';
import 'services/font_service.dart';
import 'services/logger.dart';
import 'stores/font_icon_store.dart';
import 'stores/font_icons_pacakges_store.dart';

final getIt = GetIt.instance;

/// [isUiThread] is helpufull to use for deps prepration in other isolate
Future<void> configureDependencies({bool isUiThread = true}) async {
  final modules = _Modules();

  getIt.registerSingleton<Dio>(modules.dio);

  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<FontService>(FontService());
  getIt.registerSingleton<FontIconsApi>(FontIconsApi());

  if (isUiThread) {
    await Hive.initFlutter();

    final likedIconsStorage = await LikedIconsStorage.open();

    getIt.registerSingleton<LikedIconsStorage>(likedIconsStorage);

    getIt.registerSingleton(FontIconsPackagesStore());
  }

  getIt.registerLazySingleton<FontIconsStore>(
    () => throw UnimplementedError(
        "You Can't access global value you have to shadow it"),
  );
}

class _Modules {
  Dio get dio => Dio();
}
