import 'package:broadcast_events/broadcast_events.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  _incrementHandler(_) {
    this._incrementCounter();
  }

  @override
  void initState() {
    // Add a Subscription to Increment Event
    BroadcastEvents().subscribe('INCEREMENT_EVENT', _incrementHandler);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Broadcast Events Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // Publish Increment Event
          BroadcastEvents().publish('INCEREMENT_EVENT')
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    // To dispose handler from this widget, use this
    BroadcastEvents()
        .unsubscribe('INCEREMENT_EVENT', handler: _incrementHandler);

    // To dispose handlers from everywhere, use this
    BroadcastEvents().unsubscribe('INCEREMENT_EVENT');

    super.dispose();
  }
}
