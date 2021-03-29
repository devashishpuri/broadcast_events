# flutter_broadcast_receiver

Enables you to broadcast events in your app.

## Usage

```yaml
flutter_broadcast_receiver: ^1.0.0+2
```

```dart
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
```

## Param Usage
* `CUSTOM_EVENT` Param key that must match with publisher
* `message` Returned data from publisher
* `<anyDataType>` Data Type returned from publisher or Data Type send from publisher
* `argument` data from publisher (can be any data type)

```dart
/// Subscription Example
BroadcastReceiver()
.subscribe<String> // Data Type returned from publisher
           ('CUSTOM_EVENT' ,(message) {
              print(me ssage);
            });

/// Publishing Event
BroadcastReceiver()
    .publish<String>('CUSTOM_EVENT', arguments: 'Hello Subscribers');

/// Unsubscription Example
BroadcastReceiver().unsubscribe<int>('CUSTOM_EVENT_2', handler: _handler);

/// Receiving Event
final _handler = (int code) => print('The Code is: $code');
BroadcastReceiver().subscribe<int>('CUSTOM_EVENT_2', _handler);
```

