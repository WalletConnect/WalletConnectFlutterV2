import 'package:event/event.dart';

class StoreCreateEvent<T> extends EventArgs {
  final String key;
  final T value;

  StoreCreateEvent(
    this.key,
    this.value,
  );
}

class StoreUpdateEvent<T> extends EventArgs {
  final String key;
  final T value;

  StoreUpdateEvent(
    this.key,
    this.value,
  );
}

class StoreDeleteEvent<T> extends EventArgs {
  final String key;
  final T value;

  StoreDeleteEvent(
    this.key,
    this.value,
  );
}

class StoreSyncEvent extends EventArgs {
  StoreSyncEvent();
}
