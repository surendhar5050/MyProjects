import 'package:counterapp_unittesting/counter.dart';
import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key, required this.title});

  final String title;

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  Counter counter = Counter();
  void _incrementCounter() {
    setState(() {
      counter.increment();
    });
  }

  void decrement() {
    setState(() {
      counter.decrement();
    });
  }void reset() {
    setState(() {
      counter.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.getcount}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), FloatingActionButton(
        onPressed: decrement,
        tooltip: 'decrement',
        child: const Icon(Icons.minimize),
      ) ,FloatingActionButton(
        onPressed: reset,
        tooltip: 'Reset',
        child: const Icon(Icons.replay_outlined),
      )
        ],
      ),
    );
  }
}
