import 'package:flutter/widgets.dart';

import 'package:get_it/get_it.dart';

import '../../configure_dependencies.dart';

class ScopedInjector extends StatefulWidget {
  final String scopeName;
  final Widget child;
  final void Function(GetIt)? onPushScope;
  final void Function()? onPopScope;

  const ScopedInjector({
    required this.scopeName,
    required this.child,
    this.onPushScope,
    this.onPopScope,
    Key? key,
  }) : super(key: key);

  @override
  _ScopedInjectorState createState() => _ScopedInjectorState();
}

class _ScopedInjectorState extends State<ScopedInjector> {
  @override
  void initState() {
    super.initState();
    getIt.pushNewScope(
      scopeName: widget.scopeName,
      init: (scopedGetit) => widget.onPushScope?.call(scopedGetit),
      dispose: () => widget.onPopScope?.call(),
    );
  }

  @override
  void dispose() {
    getIt.popScopesTill(widget.scopeName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
