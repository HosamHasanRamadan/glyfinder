// Package imports:

import 'package:riverpod/riverpod.dart';

import 'package:glyfinder/local_storage/liked_icons_storage.dart';

// ignore: top_level_function_literal_block
final likeIconsStreamProvider = StreamProvider((ref) async* {
  final likedIconsStorage = await ref.read(likedIconsStorageProvider.future);
  // initial value for likde icons
  yield likedIconsStorage.getAll();

  yield* likedIconsStorage.stream;
});
