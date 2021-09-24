import 'package:flutter/material.dart';

import 'package:flutter_command/flutter_command.dart';

import '../../commands/icon_commnds/search_for_icons.dart';
import '../../configure_dependencies.dart';
import '../../data/font_icon.dart';
import '../../stores/font_icon_store.dart';
import '../../utils/widgets/scoped_injector.dart';
import '../widgets/icon_tile.dart';

const _scope = 'IconsSearchPage';

class IconsSearchPage extends StatefulWidget {
  static PageRoute route(String searchValue) {
    return MaterialPageRoute(
      settings: RouteSettings(
        name: 'search',
        arguments: searchValue,
      ),
      builder: (_) {
        return ScopedInjector(
          scopeName: _scope,
          onPushScope: (scopedGetIt) =>
              scopedGetIt.registerSingleton<FontIconsStore>(
            FontIconsStore(),
            dispose: (store) => store.dispose(),
          ),
          child: const IconsSearchPage(),
        );
      },
    );
  }

  const IconsSearchPage({Key? key}) : super(key: key);

  @override
  _IconsSearchPageState createState() => _IconsSearchPageState();
}

class _IconsSearchPageState extends State<IconsSearchPage> {
  late Command<String, void> searchForIcons;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final searchValue = ModalRoute.of(context)?.settings.arguments as String;
    searchForIcons = Command.createAsyncNoResult((searchValue) async {
      final result = await SearchForIcons().call(searchValue);
      getIt<FontIconsStore>().init(result);
    });
    searchForIcons.call(searchValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CommandBuilder<String, void>(
        command: searchForIcons,
        onNullData: (context, param) => const IconsSearchPageContent(),
        onError: (context, p1, lastValue, p3) =>
            const Center(child: Text('Error')),
        whileExecuting: (context, lastValue, param) =>
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class IconsSearchPageContent extends StatelessWidget {
  const IconsSearchPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FontIcon>>(
      valueListenable: getIt<FontIconsStore>(),
      builder: (ctx, fontIconsStore, __) {
        return GridView.extent(
          padding: const EdgeInsets.all(15),
          maxCrossAxisExtent: 200,
          children: [
            ...fontIconsStore.map(
              (fontIcon) => IconTile(
                key: ValueKey(fontIcon.id),
                fontIcon: fontIcon,
                isLiked: fontIcon.isLiked,
                onDownload: () {
                  getIt<FontIconsStore>().downloadIcon(fontIcon);
                },
                onLike: (isLiked) {
                  if (!isLiked) {
                    getIt<FontIconsStore>().like(fontIcon);
                  } else {
                    getIt<FontIconsStore>().unLike(fontIcon);
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}
