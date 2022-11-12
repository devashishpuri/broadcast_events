library broadcast_events;

typedef EventHandler<T> = void Function(T args);

/// The Custom Events Service that can publish data
/// from one module/component to another.
class BroadcastEvents {
  static final BroadcastEvents _singleton = new BroadcastEvents._internal();

  Map<String, dynamic> _callbackMaps = Map<String, dynamic>();

  factory BroadcastEvents() {
    return _singleton;
  }

  BroadcastEvents._internal();

  /// Subscribe to an event topic. Events that
  /// get posted to that topic will trigger
  /// the provided handler
  ///
  /// * [topic] The topic to subscribe to
  /// * [handler] The event handler
  subscribe<T>(String topic, EventHandler<T> handler) {
    if (_callbackMaps[topic] == null) {
      _callbackMaps[topic] = [].cast<EventHandler<T>>();
    }
    List<EventHandler<T>> handlers = _callbackMaps[topic];
    handlers.add(handler);
  }

  /// Unsubscribe from the given topic. Your handler
  /// will no longer recieve events published to this
  /// topic.
  ///
  /// If [handler] is not provided, all subscribers
  /// from the [topic] are Unsubscribed. Useful in cases
  /// when you need to clear all handlers.
  ///
  /// * [topic] The topic to unsubscribe from
  /// * [handler] The event handler
  unsubscribe<T>(String topic, {EventHandler<T>? handler}) {
    if (handler == null) {
      _callbackMaps.remove(topic);
      return;
    }

    final handlers = _callbackMaps[topic];
    if (handlers == null) {
      return;
    }

    // We now need to remove specific handler
    final handlerIndex = handlers.indexOf(handler);

    if (handlerIndex >= 0) {
      handlers.removeAt(handlerIndex);
      if (handlers.length == 0) {
        _callbackMaps.remove(topic);
      }
    }
  }

  /// Publish an Event to given topic.
  /// * [topic] The topic to publish to
  /// * [arguments] The arguments to pass to
  ///
  /// Pass null in [arguments] if not required,
  /// And use ? with the Type
  /// the handlers.
  publish<T>(String topic, {required T arguments}) {
    List<EventHandler<T>> handlers;
    try {
      handlers = _callbackMaps[topic] ?? [];
    } catch (_) {
      throw FormatException(
          'Type mismatch between Publisher Arguments and what Subscriber Expects');
    }

    handlers.forEach((EventHandler<T> handler) {
      try {
        handler(arguments);
      } catch (_) {
        print('Error Occured while executing handler for topic $topic');
        print(_);
      }
    });
  }
}
