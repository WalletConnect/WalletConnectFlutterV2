import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_bottom_sheet_service.dart';

class BottomSheetService extends IBottomSheetService {
  final BuildContext context;

  BottomSheetService(this.context);

  Queue queue = Queue<BottomSheetQueueItem>();
  bool bottomSheetIsOpen = false;

  @override
  Future<dynamic> queueBottomSheet({
    required Widget widget,
    BuildContext? context,
  }) async {
    // Create the bottom sheet queue item
    final completer = Completer<dynamic>();
    final queueItem = BottomSheetQueueItem(
      widget: widget,
      context: context ?? this.context,
      completer: completer,
    );
    queue.add(queueItem);

    // If the bottom sheet not open, show next
    if (!bottomSheetIsOpen) {
      showNext();
    }

    // Return the future
    return await completer.future;
  }

  Future<dynamic> showNext() async {
    bottomSheetIsOpen = true;

    // Get the next item in the queue
    final BottomSheetQueueItem queueItem = queue.removeFirst();

    final value = await showModalBottomSheet(
      context: queueItem.context,
      builder: (context) {
        return queueItem.widget;
      },
    );

    // Complete the future
    queueItem.completer.complete(value);

    // Bottom sheet is no longer open
    bottomSheetIsOpen = false;

    // If the queue is not empty, show the next item
    if (queue.isNotEmpty) {
      showNext();
    }
  }
}
