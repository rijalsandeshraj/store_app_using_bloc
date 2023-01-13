class Product {
  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.quantity = 1,
    this.addedToCart = false,
    this.isFavorite = false,
  });

  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  int quantity;
  bool addedToCart;
  bool isFavorite;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble() ?? 0,
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating!.toJson(),
      };

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
    int? quantity,
    bool? addedToCart,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      addedToCart: addedToCart ?? this.addedToCart,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }
}

class Rating {
  Rating({
    this.rate,
    this.count,
  });

  double? rate;
  int? count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
