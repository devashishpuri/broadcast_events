import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';

void main() {
  /// Test Subscription
  BroadcastReceiver().subscribe('CUSTOM_EVENT', (message) {
    print(message);
  });

  BroadcastReceiver()
      .publish('CUSTOM_EVENT', arguments: 'Hello Cuk');

  /// Test Unsubscription
  final _handler = (int code) => print('The Code is: $code');

  BroadcastReceiver().subscribe<int>('CUSTOM_EVENT_2', _handler);

  BroadcastReceiver().subscribe<int>('CUSTOM_EVENT_2', (code) {
    print('The Code from Subscriber that didn\'t Unsubscribe: $code');
  });

  BroadcastReceiver().unsubscribe<int>('CUSTOM_EVENT_2', handler: _handler);

  BroadcastReceiver().publish<int>('CUSTOM_EVENT_2', arguments: 2);

  /// Test Type Error
  BroadcastReceiver().publish<int>('CUSTOM_EVENT', arguments: 5);
}
