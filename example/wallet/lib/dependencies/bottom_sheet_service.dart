import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';

class BottomSheetService extends IBottomSheetService {
  BuildContext context;

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

  @override
  void setDefaultContext(BuildContext context) {
    this.context = context;
  }

  Future<dynamic> showNext() async {
    bottomSheetIsOpen = true;

    // Get the next item in the queue
    final BottomSheetQueueItem queueItem = queue.removeFirst();

    final value = await showModalBottomSheet(
      context: queueItem.context,
      backgroundColor: StyleConstants.clear,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: StyleConstants.layerColor1,
            borderRadius: BorderRadius.all(
              Radius.circular(
                StyleConstants.linear16,
              ),
            ),
          ),
          padding: const EdgeInsets.all(
            StyleConstants.linear16,
          ),
          margin: const EdgeInsets.all(
            StyleConstants.linear16,
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 1.8,
          ),
          child: queueItem.widget,
        );
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
