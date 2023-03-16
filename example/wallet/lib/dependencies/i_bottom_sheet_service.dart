import 'dart:async';

import 'package:flutter/material.dart';

class BottomSheetQueueItem {
  final Widget widget;
  final BuildContext context;
  final Completer<dynamic> completer;

  BottomSheetQueueItem({
    required this.widget,
    required this.context,
    required this.completer,
  });
}

abstract class IBottomSheetService {
  Future<dynamic> queueBottomSheet({
    required Widget widget,
    BuildContext? context,
  });
}
