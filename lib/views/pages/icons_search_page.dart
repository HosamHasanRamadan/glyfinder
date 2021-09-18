import 'package:flutter/material.dart';

import 'package:flutter_command/flutter_command.dart';

import '../../commands/icon_commnds/search_for_icons.dart';
import '../../data/font_icon.dart';
import '../../stores/font_icon_store.dart';
import '../widgets/icon_tile.dart';

class IconsSearchPage extends StatefulWidget {
  static PageRoute route(String searchValue) {
    return MaterialPageRoute(
        settings: RouteSettings(
          name: 'search',
          arguments: searchValue,
        ),
        builder: (_) {
          return const IconsSearchPage();
        });
  }

  const IconsSearchPage({Key? key}) : super(key: key);

  @override
  _IconsSearchPageState createState() => _IconsSearchPageState();
}

class _IconsSearchPageState extends State<IconsSearchPage> {
  late Command<String, List<FontIcon>> searchForIcons;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final searchValue = ModalRoute.of(context)?.settings.arguments as String;
    searchForIcons = Command.createAsync((searchValue) async {
      final result = await SearchForIcons().call(searchValue);
      return result;
    }, []);
    searchForIcons.call(searchValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CommandBuilder<String, List<FontIcon>>(
        command: searchForIcons,
        onData: (context, data, param) => IconsSearchPageContent(
          searchValue: param!,
          fontIconsStore: FontIconsStore(data),
        ),
        onError: (context, p1, lastValue, p3) =>
            const Center(child: Text('Error')),
        whileExecuting: (context, lastValue, param) =>
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class IconsSearchPageContent extends StatelessWidget {
  final String searchValue;
  final FontIconsStore fontIconsStore;
  const IconsSearchPageContent({
    required this.searchValue,
    required this.fontIconsStore,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FontIcon>>(
      valueListenable: fontIconsStore,
      builder: (ctx, fontIcons, __) {
        return GridView.extent(
          padding: const EdgeInsets.all(15),
          maxCrossAxisExtent: 200,
          children: [
            ...fontIcons.map(
              (fontIcon) => IconTile(
                key: ValueKey(fontIcon.id),
                fontIcon: fontIcon,
                isLiked: fontIcon.isLiked,
                onDownload: () {
                  fontIconsStore.downloadIcon(fontIcon);
                },
                onLike: (isLiked) {
                  if (!isLiked) {
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
    );
  }
}
