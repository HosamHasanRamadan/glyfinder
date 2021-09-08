import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod/riverpod.dart';

import 'package:glyfinder/commands/get_font_icons_packages.dart';
import 'package:glyfinder/commands/load_fonts.dart';
import 'package:glyfinder/services/logger.dart';
import 'package:glyfinder/views/pages/home_page.dart';

final bootstrabProvider =
    StreamProvider.family<String, BuildContext>((ref, context) async* {
  final logger = ref.read(loggerProvider);

  logger.i('bootstraping....');

  logger.i('prepareing local stoarage....');
  await Hive.initFlutter();

  yield 'Loading All Icons....';
  await ref.read(getFontIconsPacakgesProvider).command.executeWithFuture();

  yield 'Loading All Fonts...';
  await ref.read(loadFontsProvider).command.executeWithFuture();

  yield 'Done';
  logger.i('bootstraping ✅');

  await Future<void>.delayed(const Duration(seconds: 1));

  Navigator.pushAndRemoveUntil<void>(
    context,
    MaterialPageRoute(builder: (_) => HomePage()),
    (_) => false,
  );
});
