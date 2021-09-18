import 'package:flutter/material.dart';

import '../../../commands/get_liked_icons.dart';
import '../../../data/font_icon.dart';
import '../../../stores/font_icon_store.dart';
import '../../widgets/icon_tile.dart';

class LikePage extends StatelessWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _LikePageContent(
      FontIconsStore(
        GetLikedIcons().call(),
      ),
    );
  }
}

class _LikePageContent extends StatelessWidget {
  final FontIconsStore fontIconsStore;
  const _LikePageContent(
    this.fontIconsStore, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<List<FontIcon>>(
        valueListenable: fontIconsStore,
        builder: (context, fontIcons, child) {
          return GridView.extent(
            padding: const EdgeInsets.all(15),
            maxCrossAxisExtent: 200,
            // childAspectRatio: 1,
            children: [
              ...fontIcons.map(
                (fontIcon) => IconTile(
                  key: ValueKey(fontIcon.id),
                  fontIcon: fontIcon,
                  isLiked: fontIcon.isLiked,
                  onDownload: () {},
                  onLike: (_) {
                    if (!fontIcon.isLiked) {
                      fontIconsStore.like(fontIcon);
                    } else {
                      fontIconsStore.unLike(fontIcon);
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
