import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  String? category;
  num? discount;
  String? name;
  String? photo;
  num? price;
  num? productID;
  num? total;
  ProductModel({
    this.category,
    this.discount,
    this.name,
    this.photo,
    this.price,
    this.productID,
    this.total,
  });

  ProductModel copyWith({
    String? category,
    num? discount,
    String? name,
    String? photo,
    num? price,
    num? productID,
    num? total,
  }) {
    return ProductModel(
      category: category ?? this.category,
      discount: discount ?? this.discount,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      price: price ?? this.price,
      productID: productID ?? this.productID,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'discount': discount,
      'name': name,
      'photo': photo,
      'price': price,
      'productID': productID,
      'total': total,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      category: map['category'] != null ? map['category'] as String : null,
      discount: map['discount'] != null ? map['discount'] as num : null,
      name: map['name'] != null ? map['name'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      price: map['price'] != null ? map['price'] as num : null,
      productID: map['productID'] != null ? map['productID'] as num : null,
      total: map['total'] != null ? map['total'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(category: $category, discount: $discount, name: $name, photo: $photo, price: $price, productID: $productID, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.category == category &&
        other.discount == discount &&
        other.name == name &&
        other.photo == photo &&
        other.price == price &&
        other.productID == productID &&
        other.total == total;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        discount.hashCode ^
        name.hashCode ^
        photo.hashCode ^
        price.hashCode ^
        productID.hashCode ^
        total.hashCode;
  }
}
