import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../commands/get_liked_icons.dart';
import '../../../stores/font_icon_store.dart';
import '../../widgets/icon_tile.dart';

class LikePage extends StatelessWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FontIconsStore(GetLikedIcons().call()),
      child: const _LikePageContent(),
    );
  }
}

class _LikePageContent extends StatelessWidget {
  const _LikePageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FontIconsStore>(
      builder: (context, fontIconsStore, child) {
        return Center(
          child: GridView.extent(
            padding: const EdgeInsets.all(15),
            maxCrossAxisExtent: 200,
            // childAspectRatio: 1,
            children: [
              ...fontIconsStore.value.map(
                (fontIcon) => IconTile(
                  key: ValueKey(fontIcon.id),
                  fontIcon: fontIcon,
                  isLiked: fontIcon.isLiked,
                  onDownload: () {
                    fontIconsStore.downloadIcon(fontIcon);
                  },
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
          ),
        );
      },
    );
  }
}
