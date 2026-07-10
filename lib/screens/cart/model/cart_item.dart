class CartItem {
  const CartItem({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  final int id;
  final String title;
  final String image;
  final double price;
  final int quantity;

  double get subtotal => price * quantity;

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int? ?? 0,
      title: map['title'] as String? ?? '',
      image: map['image'] as String? ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      quantity: map['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      id: id,
      title: title,
      image: image,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}