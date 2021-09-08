import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glyfinder/commands/icon_commnds/download_icon.dart';
import 'package:glyfinder/commands/icon_commnds/like_icon.dart';
import 'package:glyfinder/commands/icon_commnds/unlike_icon.dart';
import 'package:glyfinder/data/font_icon.dart';
import 'package:glyfinder/stores/font_icon_store.dart';
import 'package:glyfinder/views/widgets/icon_tile.dart';

class IconsSearchPage extends StatelessWidget {
  final List<FontIcon> fontIcons;
  final String searchValue;
  const IconsSearchPage({
    required this.searchValue,
    required this.fontIcons,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(searchValue),
      ),
      body: Consumer(
        builder: (ctx, watch, __) {
          final fontIcons = watch(fontIconsStoreProvider).value;
          return GridView.extent(
            padding: const EdgeInsets.all(15),
            maxCrossAxisExtent: 200,
            children: [
              ...fontIcons.map(
                (fontIcon) => IconTile(
                  key: ValueKey(fontIcon.id),
                  fontIcon: fontIcon,
                  isLiked: fontIcon.isLiked,
                  onDownload: () =>
                      ctx.read(downloadIconProvider).command(fontIcon),
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
          );
        },
      ),
    );
  }
}
