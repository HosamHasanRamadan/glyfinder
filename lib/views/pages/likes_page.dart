import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glyfinder/commands/icon_commnds/download_icon.dart';
import 'package:glyfinder/commands/icon_commnds/like_icon.dart';
import 'package:glyfinder/commands/icon_commnds/unlike_icon.dart';
import 'package:glyfinder/stores/liked_icons_store.dart';
import 'package:glyfinder/views/widgets/icon_tile.dart';

class LikePage extends StatelessWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, watch, child) {
          final likesIcons = watch(likeIconsStreamProvider);
          return likesIcons.when(
            data: (fontIcons) => GridView.extent(
              padding: const EdgeInsets.all(15),
              maxCrossAxisExtent: 200,
              // childAspectRatio: 1,
              children: [
                ...fontIcons.map(
                  (fontIcon) => IconTile(
                    key: ValueKey(fontIcon.id),
                    fontIcon: fontIcon,
                    isLiked: fontIcon.isLiked,
                    onDownload: () =>
                        context.read(downloadIconProvider).command(fontIcon),
                    onLike: (_) {
                      if (fontIcon.isLiked) {
                        context.read(unlikeIconProvider).command(fontIcon);
                      } else {
                        context.read(likeIconProvider).command(fontIcon);
                      }
                    },
                  ),
                )
              ],
            ),
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const Text('error'),
          );
        },
      ),
    );
  }
}
