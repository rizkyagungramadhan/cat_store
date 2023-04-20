import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension BuildContextExt on BuildContext {
  /// Doc : If dialog is open will dismiss current showing dialog,
  /// if no dialog opens will go back.
  /// [twice] if true dismissing the dialog automatically & back to last page.
  void dismiss([bool twice = false]) async {
    Navigator.of(this, rootNavigator: true).pop(this);
    if (twice) {
      await Future.delayed(const Duration(milliseconds: 250), () => dismiss());
    }
  }

  void onBuildCompleted(Function()? method) {
    SchedulerBinding.instance.addPostFrameCallback((_) => method?.call());
  }

  int? fitImageCache(double? size) {
    if (size == null) return null;
    return (MediaQuery.of(this).devicePixelRatio * size).round();
  }
}
