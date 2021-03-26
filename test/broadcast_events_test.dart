import 'package:broadcast_events/broadcast_events.dart';

void main() {
  /// Test Subscription
  BroadcastEvents().subscribe('CUSTOM_EVENT', (message) {
    print(message);
  });

  BroadcastEvents()
      .publish('CUSTOM_EVENT', arguments: 'Hello Cuk');

  /// Test Unsubscription
  final _handler = (int code) => print('The Code is: $code');

  BroadcastEvents().subscribe<int>('CUSTOM_EVENT_2', _handler);

  BroadcastEvents().subscribe<int>('CUSTOM_EVENT_2', (code) {
    print('The Code from Subscriber that didn\'t Unsubscribe: $code');
  });

  BroadcastEvents().unsubscribe<int>('CUSTOM_EVENT_2', handler: _handler);

  BroadcastEvents().publish<int>('CUSTOM_EVENT_2', arguments: 2);

  /// Test Type Error
  BroadcastEvents().publish<int>('CUSTOM_EVENT', arguments: 5);
}
