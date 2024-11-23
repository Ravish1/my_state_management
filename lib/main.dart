import 'package:flutter/material.dart';
import 'package:my_state_management/cart_managment/screen/CartSCreen.dart';
import 'package:r_state_manager/r_state_manager.dart';

void main() {
  runApp(const MyApp());
}

// State
class CounterState {
  final int count;

  CounterState(this.count);

  CounterState copyWith({int? count}) {
    return CounterState(count ?? this.count);
  }
}

// Events
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

// Manager
class CounterManager extends RStateManager<CounterState, CounterEvent> {
  CounterManager()
      : super(CounterState(0), (state, event) {
    if (event is IncrementEvent) {
      return state.copyWith(count: state.count + 1);
    }
    return state;
  });
}

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final counterManager = CounterManager();

    return RState<CounterState, CounterEvent>(
      manager: counterManager,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Selective Update Example'),
          ),
          body:  CartScreen(),
        ),
      ),
    );
  }
}

// Widget Tree
class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '1. Static Text',
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          '2. Static Text',
          style: TextStyle(fontSize: 20),
        ),
        // The third Text widget listens to state updates via RConsumer
        RConsumer<CounterState, CounterEvent>(
          builder: (context, state) {
            return Text(
              '3. Dynamic Count: ${state.count}',
              style: const TextStyle(fontSize: 20, color: Colors.blue),
            );
          },
        ),
        const Text(
          '4. Static Text',
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          '5. Static Text',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            RState.of<CounterState, CounterEvent>(context)!
                .manager
                .dispatch(IncrementEvent());
          },
          child: const Text('Increment Count'),
        ),
      ],
    );
  }
}
