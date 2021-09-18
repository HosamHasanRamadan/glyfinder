import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commands/bootstrap.dart';
import 'home_page/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<AsyncValue<String>>(
        onChange: (ctx, value) {
          value.whenData((value) {
            if (value == 'Done') Navigator.of(context).push(HomePage.route());
          });
        },
        provider: bootstrabProvider,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'GlyFinder',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Consumer(builder: (ctx, watch, __) {
                  final value = watch(bootstrabProvider);
                  return value.when(
                    data: (data) => Text(data),
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Text('erro'),
                  );
                })
              ],
            ),
          ),
        ));
  }
}
