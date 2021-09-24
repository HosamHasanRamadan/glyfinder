import 'package:flutter/material.dart';

import '../../../commands/get_liked_icons.dart';
import '../../../configure_dependencies.dart';
import '../../../data/font_icon.dart';
import '../../../stores/font_icon_store.dart';
import '../../../utils/widgets/scoped_injector.dart';
import '../../widgets/icon_tile.dart';

class LikePage extends StatelessWidget {
  const LikePage({Key? key}) : super(key: key);

  static const _scope = 'LikePage';

  @override
  Widget build(BuildContext context) {
    return ScopedInjector(
      onPushScope: (scopedGetit) =>
          scopedGetit.registerSingleton<FontIconsStore>(
              FontIconsStore(GetLikedIcons().call()),
              dispose: (store) => store.dispose()),
      scopeName: _scope,
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
    return ValueListenableBuilder<List<FontIcon>>(
      valueListenable: getIt<FontIconsStore>(),
      builder: (context, fontIconsStore, child) {
        return Center(
          child: GridView.extent(
            padding: const EdgeInsets.all(15),
            maxCrossAxisExtent: 200,
            // childAspectRatio: 1,
            children: [
              ...fontIconsStore.map(
                (fontIcon) => IconTile(
                  key: ValueKey(fontIcon.id),
                  fontIcon: fontIcon,
                  isLiked: fontIcon.isLiked,
                  onDownload: () {
                    getIt<FontIconsStore>().downloadIcon(fontIcon);
                  },
                  onLike: (_) {
                    if (!fontIcon.isLiked) {
                      getIt<FontIconsStore>().like(fontIcon);
                    } else {
                      getIt<FontIconsStore>().unLike(fontIcon);
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
