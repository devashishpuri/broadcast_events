import 'package:broadcast_events/broadcast_events.dart';

void main() {
  /// Test Event Subscription
  BroadcastEvents().subscribe<String>('CUSTOM_EVENT', (message) {
    print(message);
  });

  BroadcastEvents()
      .publish<String>('CUSTOM_EVENT', arguments: 'Hello Subscribers');

  /// Test Event Unsubscription
  final _handler = (int code) => print('The Code is: $code');

  BroadcastEvents().subscribe<int>('CUSTOM_EVENT_2', _handler);

  BroadcastEvents().subscribe<int>('CUSTOM_EVENT_2', (code) {
    print('The Code from Subscriber that didn\'t Unsubscribe: $code');
  });

  BroadcastEvents().unsubscribe<int>('CUSTOM_EVENT_2', handler: _handler);
  BroadcastEvents().publish<int>('CUSTOM_EVENT_2', arguments: 2);

  // Clean old subscriptions
  BroadcastEvents().unsubscribe('CUSTOM_EVENT');
  BroadcastEvents().unsubscribe('CUSTOM_EVENT_2');

  /// Test Type Error
  BroadcastEvents().subscribe<String>('CUSTOM_EVENT', (_) => {});
  BroadcastEvents().publish('CUSTOM_EVENT', arguments: 5);
}
