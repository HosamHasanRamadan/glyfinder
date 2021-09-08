import 'package:flutter/material.dart';

import 'package:glyfinder/extensions/extensions.dart';
import 'package:glyfinder/views/pages/likes_page.dart';
import 'package:glyfinder/views/pages/search_page.dart';

class HomePage extends StatelessWidget {
  final pageViewController = PageController();
  final indexValue = 0.listenable;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        ValueListenableBuilder<int>(
          valueListenable: indexValue,
          builder: (_, newIndex, __) => NavigationRail(
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.search), label: Text('search')),
              NavigationRailDestination(
                  icon: Icon(Icons.favorite), label: Text('likes')),
            ],
            onDestinationSelected: (index) {
              indexValue.value = index;
              pageViewController.animateToPage(
                index,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 200),
              );
            },
            selectedIndex: newIndex,
          ),
        ),
        Expanded(
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: pageViewController,
            children: const [
              SearchPage(),
              LikePage(),
            ],
          ),
        )
      ],
    ));
  }
}
