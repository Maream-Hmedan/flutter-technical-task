class ProductResponse {
  const ProductResponse({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ProductRating rating;

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      image: json['image'] as String? ?? '',
      rating: ProductRating.fromJson(
        json['rating'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }
}

class ProductRating {
  const ProductRating({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}