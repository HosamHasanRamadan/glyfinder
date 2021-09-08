import 'package:flutter/cupertino.dart';

extension ObjectX<T extends Object> on T {
  ValueNotifier<T> get listenable => ValueNotifier<T>(this);
}
