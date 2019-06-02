# broadcast_events

Enables you to broadcast events in your app.

## Usage

```dart
/// Subscription Example
BroadcastEvents().subscribe<String>('CUSTOM_EVENT', (message) {
    print(message);
});

BroadcastEvents()
    .publish<String>('CUSTOM_EVENT', arguments: 'Hello Subscribers');

/// Unsubscription Example
final _handler = (int code) => print('The Code is: $code');

BroadcastEvents().subscribe<int>('CUSTOM_EVENT_2', _handler);

BroadcastEvents().unsubscribe<int>('CUSTOM_EVENT_2', handler: _handler);

BroadcastEvents().publish<int>('CUSTOM_EVENT_2', arguments: 2);
```

