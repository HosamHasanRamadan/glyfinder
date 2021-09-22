import 'package:flutter/material.dart';

import 'package:mainstream/mainstream.dart';

import '../../commands/bootstrap.dart';
import 'home_page/home_page.dart';

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
            MainStream<String>(
              stream: Bootstrap().call(),
              onDone: () => Navigator.of(context).pushAndRemoveUntil(
                HomePage.route(),
                (_) => false,
              ),
              dataBuilder: (_, value) => Text(value!),
              errorBuilder: (_, __) => const Text('Error'),
              busyBuilder: (context) => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
