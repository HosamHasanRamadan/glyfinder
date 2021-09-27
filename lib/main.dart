import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'configure_dependencies.dart';
import 'stores/font_icons_pacakges_store.dart';
import 'views/pages/intro_page.dart';

void main() async {
  await configureDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<FontIconsPackagesStore>())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IntroPage(),
    );
  }
}
