import 'package:flutter/material.dart';
import 'package:r_state_manager/r_state_manager.dart';

import '../r_state_logic/CartEvent.dart';
import '../r_state_logic/CartLogic.dart';
import '../r_state_logic/CartState.dart';
// Import RConsumer



// Import RConsumer



class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the CartManager from the context and wrap it using RState
    final cartManager = CartManager();

    return RState<CartState, CartEvent>(
      manager: cartManager,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Using RConsumer to listen to CartState changes
              RConsumer<CartState, CartEvent>(
                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CartFailureState) {
                    return Center(child: Text('Error: ${state.error}', style: TextStyle(color: Colors.red)));
                  } else if (state is CartSuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cart Items:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        // Accessing items and total safely for CartSuccessState
                        ...state.items.map((item) => Text(item)).toList(),
                        SizedBox(height: 10),
                        Text('Total: \$${state.total}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    );
                  } else if (state is CartInitialState) {
                    // Handling CartInitialState which also has items and total
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cart Items:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        ...state.items.map((item) => Text(item)).toList(),
                        SizedBox(height: 10),
                        Text('Total: \$${state.total}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    );
                  }
                  return Container(); // Empty container if the state is unknown
                },
              ),
              SizedBox(height: 30),
              // Buttons to add/remove items
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cartManager.dispatch(AddItemEvent(item: 'Apple', price: 1.5));
                      },
                      child: Text('Add Apple (\$1.5)'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cartManager.dispatch(AddItemEvent(item: 'Banana', price: 2.0));
                      },
                      child: Text('Add Banana (\$2.0)'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cartManager.dispatch(RemoveItemEvent(item: 'Apple', price: 1.5));
                      },
                      child: Text('Remove Apple'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

