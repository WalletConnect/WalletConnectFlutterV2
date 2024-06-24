import 'dart:async';

import 'package:flutter/material.dart';

enum WCBottomSheetResult {
  reject,
  one,
  all,
}

class BottomSheetQueueItem {
  final Widget widget;
  final Completer<dynamic> completer;
  final int closeAfter;

  BottomSheetQueueItem({
    required this.widget,
    required this.completer,
    this.closeAfter = 0,
  });
}

abstract class IBottomSheetService {
  abstract final ValueNotifier<BottomSheetQueueItem?> currentSheet;

  Future<dynamic> queueBottomSheet({
    required Widget widget,
    int closeAfter = 0,
  });

  void showNext();
}
