// lib/cart_manager.dart


import 'package:r_state_manager/r_state_manager.dart';

import 'CartEvent.dart';
import 'CartState.dart'; // Import the RStateManager package

class CartManager extends RStateManager<CartState, CartEvent> {
  // Constructor with initial state and event handler
  CartManager()
      : super(
    CartInitialState(), // Initial state
    _handleEvent, // Event handler function
  );

  // Static method that processes events
  static CartState _handleEvent(CartState currentState, CartEvent event) {
    if (event is AddItemEvent) {
      return _addItem(currentState, event.item, event.price);
    } else if (event is RemoveItemEvent) {
      return _removeItem(currentState, event.item, event.price);
    }
    return currentState; // Return current state if event is not recognized
  }

  // Handling add item event
  static CartState _addItem(CartState currentState, String item, double price) {
    if (currentState is CartInitialState) {
      final updatedItems = List<String>.from(currentState.items)..add(item);
      final updatedTotal = currentState.total + price;
      return CartSuccessState(items: updatedItems, total: updatedTotal);
    }
    return currentState;
  }

  // Handling remove item event
  static CartState _removeItem(CartState currentState, String item, double price) {
    if (currentState is CartInitialState) {
      final updatedItems = List<String>.from(currentState.items)..remove(item);
      final updatedTotal = currentState.total - price;
      return CartSuccessState(items: updatedItems, total: updatedTotal);
    }
    return currentState;
  }
}
