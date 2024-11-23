// lib/cart_event.dart

abstract class CartEvent {}

class AddItemEvent extends CartEvent {
  final String item;
  final double price;

  AddItemEvent({required this.item, required this.price});
}

class RemoveItemEvent extends CartEvent {
  final String item;
  final double price;

  RemoveItemEvent({required this.item, required this.price});
}
