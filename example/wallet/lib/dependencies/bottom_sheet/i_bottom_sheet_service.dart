import 'dart:async';

import 'package:flutter/material.dart';

class BottomSheetQueueItem {
  final Widget widget;
  final Completer<dynamic> completer;

  BottomSheetQueueItem({
    required this.widget,
    required this.completer,
  });
}

abstract class IBottomSheetService {
  abstract final ValueNotifier<BottomSheetQueueItem?> currentSheet;

  Future<dynamic> queueBottomSheet({
    required Widget widget,
  });

  void showNext();
}
