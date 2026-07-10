import 'package:flutter_technical_task/screens/cart/database/cart_database.dart';
import 'package:flutter_technical_task/screens/cart/model/cart_item.dart';

class CartRepository {
  CartRepository({
    CartDatabase? database,
  }) : _database = database ?? CartDatabase.instance;

  final CartDatabase _database;

  Future<List<CartItem>> getCartItems() async {
    return await _database.getCartItems();
  }

  Future<void> addCartItem(CartItem item) async {
    await _database.insertCartItem(item);
  }

  Future<void> updateCartItem(CartItem item) async {
    await _database.updateCartItem(item);
  }

  Future<void> deleteCartItem(int id) async {
    await _database.deleteCartItem(id);
  }

  Future<void> clearCart() async {
    await _database.clearCart();
  }
}