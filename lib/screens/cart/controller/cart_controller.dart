import 'package:flutter/material.dart';
import 'package:flutter_technical_task/screens/cart/model/cart_item.dart';
import 'package:flutter_technical_task/screens/cart/repository/cart_repository.dart';
import 'package:flutter_technical_task/screens/product/model/product_response.dart';

class CartController extends ChangeNotifier {
  CartController({
    required CartRepository repository,
  }) : _repository = repository;

  final CartRepository _repository;

  List<CartItem> cartItems = [];

  Future<void> loadCart() async {
    cartItems = await _repository.getCartItems();
    notifyListeners();
  }

  Future<void> addProduct(
      ProductResponse product,
      ) async {
    final int index = cartItems.indexWhere(
          (item) => item.id == product.id,
    );

    if (index != -1) {
      final CartItem updatedItem = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + 1,
      );

      await _repository.updateCartItem(updatedItem);
    } else {
      final CartItem item = CartItem(
        id: product.id,
        title: product.title,
        image: product.image,
        price: product.price,
        quantity: 1,
      );

      await _repository.addCartItem(item);
    }

    await loadCart();
  }

  Future<void> increaseQuantity(
      CartItem item,
      ) async {
    final CartItem updatedItem = item.copyWith(
      quantity: item.quantity + 1,
    );

    await _repository.updateCartItem(updatedItem);

    await loadCart();
  }

  Future<void> decreaseQuantity(
      CartItem item,
      ) async {
    if (item.quantity == 1) {
      await removeProduct(item.id);
      return;
    }

    final CartItem updatedItem = item.copyWith(
      quantity: item.quantity - 1,
    );

    await _repository.updateCartItem(updatedItem);

    await loadCart();
  }

  Future<void> removeProduct(
      int id,
      ) async {
    await _repository.deleteCartItem(id);

    await loadCart();
  }

  Future<void> clearCart() async {
    await _repository.clearCart();

    await loadCart();
  }

  double get totalPrice {
    return cartItems.fold(
      0,
          (sum, item) => sum + item.subtotal,
    );
  }

  bool isProductInCart(int productId) {
    return cartItems.any(
          (item) => item.id == productId,
    );
  }
}