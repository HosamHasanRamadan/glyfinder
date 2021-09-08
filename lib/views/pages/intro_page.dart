import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glyfinder/commands/bootstrap.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              final value = watch(bootstrabProvider(ctx));
              return value.when(
                data: (data) => Text(data),
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Text('erro'),
              );
            })
          ],
        ),
      ),
    );
  }
}
