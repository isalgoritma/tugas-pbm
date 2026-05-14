class Product {

  final int id;
  final String name;
  final int price;
  final String description;
  final String imageUrl;

  Product({

    required this.id,

    required this.name,

    required this.price,

    required this.description,

    required this.imageUrl,
  });

  factory Product.fromJson(
    Map<String, dynamic> json,
  ) {

    return Product(

      id:
          int.tryParse(
            json['id']
                .toString(),
          ) ??
          0,

      name:
          json['name'] ?? '',

      price:
          double.parse(
            json['price']
                .toString(),
          ).toInt(),

      description:
          json['description'] ?? '',

      imageUrl:
          json['image_url'] ?? '',
    );
  }
}