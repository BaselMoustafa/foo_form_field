class Product {
  final int id;
  final String name;
  final double price;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          description == other.description;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode ^ description.hashCode;

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}

