class Product {
  final int id;
  final String name;
  int quantity;
  final int price; // Unit price
  final String? discountCode; // Discount code (if any)
  final double? discountPercentage; // Discount percentage (0-100)

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.discountCode,
    this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      discountCode: json['discountCode'],
      discountPercentage: json['discountPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'discountCode': discountCode,
      'discountPercentage': discountPercentage,
    };
  }
}

class Order {
  final int id;
  final String customerName;
  final String orderCode;
  final String orderDate;
  String status;
  final List<Product> products;
  final String paymentMethod; // Payment method
  final double? totalDiscount; // Total discount on the order

  Order({
    required this.id,
    required this.customerName,
    required this.orderCode,
    required this.orderDate,
    required this.status,
    required this.products,
    required this.paymentMethod,
    this.totalDiscount,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerName: json['customerName'],
      orderCode: json['orderCode'],
      orderDate: json['orderDate'],
      status: json['status'],
      products: (json['products'] as List<dynamic>)
          .map((product) => Product.fromJson(product))
          .toList(),
      paymentMethod: json['paymentMethod'],
      totalDiscount: json['totalDiscount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'orderCode': orderCode,
      'orderDate': orderDate,
      'status': status,
      'products': products.map((product) => product.toJson()).toList(),
      'paymentMethod': paymentMethod,
      'totalDiscount': totalDiscount,
    };
  }

  Order copyWith({
    int? id,
    String? customerName,
    String? orderCode,
    String? orderDate,
    String? status,
    List<Product>? products,
    String? paymentMethod,
    double? totalDiscount,
  }) {
    return Order(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      orderCode: orderCode ?? this.orderCode,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      products: products ?? this.products,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalDiscount: totalDiscount ?? this.totalDiscount,
    );
  }
}
