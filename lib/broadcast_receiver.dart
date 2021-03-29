library broadcast_receiver;

typedef EventHandler<T> = void Function(T args);

/// The Custom Events Service that can publish data
/// from one module/component to another.
class BroadcastReceiver {
  static final BroadcastReceiver _singleton = new BroadcastReceiver._internal();

  Map<String, dynamic> _callbackMaps = Map<String, dynamic>();

  factory BroadcastReceiver() {
    return _singleton;
  }

  BroadcastReceiver._internal();

  /// Subscribe to an event topic. Events that
  /// get posted to that topic will trigger
  /// the provided handler
  /// * [topic] The topic to subscribe to
  /// * [handler] The event handler
  subscribe<T>(String topic, EventHandler<T>? handler) {
    List<EventHandler<T>>? handlers = _callbackMaps[topic];
    if (handler == null) {
      _callbackMaps.remove(topic);
      return;
    }
    if (handlers == null) {
      handlers = [];
      _callbackMaps[topic] = handlers;
    }
    handlers.add(handler);
  }

  /// Unsubscribe from the given topic. Your handler
  /// will no longer recieve events published to this
  /// topic
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
  /// the handlers. It's better if custom
  /// Structure is used.
  publish<T>(String topic, {T? arguments}) {
    List<EventHandler<T>>? handlers;
    try {
      handlers = _callbackMaps[topic];
    } catch (_) {
      throw FormatException(
          'Type mismatch between Publisher Arguments and what Subscriber Expects');
    }

    if (handlers == null || handlers.isEmpty) {
      return;
    }

    handlers.forEach((EventHandler<T> handler) {
      try {
        if(arguments != null){
          handler(arguments);
        }else{
          throw 'arguments null';
        }
      } catch (_) {
        print('Error Occured while executing handler for topic $topic');
        print(_);
      }
    });
  }
}
