import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../stores/font_icons_pacakges_store.dart';
import '../icons_search_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _Logo(),
        SizedBox(height: 15),
        _SearchField(),
        SizedBox(height: 30),
        Expanded(child: _IconPacks()),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'GlyFinder',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .5;
    return SizedBox(
      width: width,
      child: TextField(
        onSubmitted: (searchValue) {
          Navigator.of(context).push(IconsSearchPage.route(searchValue));
        },
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}

class _IconPacks extends StatelessWidget {
  const _IconPacks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .8;
    return Consumer<FontIconsPackagesStore>(
      builder: (context, store, child) {
        return SizedBox(
          width: width,
          child: GridView.count(
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 5,
            children: [
              ...store.value.map((e) => Column(
                    children: [
                      Image.network(
                        e.imageUrl.toString(),
                        width: 100,
                        height: 100,
                        errorBuilder: (_, __, ___) => const Placeholder(
                          fallbackWidth: 100,
                          fallbackHeight: 100,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(e.packageName),
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
