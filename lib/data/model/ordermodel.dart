import 'crtitem.dart';

class Order {
  final List<CartItem> items;
  final DateTime orderDate;
  final String userId;
  final double totalAmount;

  Order({
    required this.items,
    required this.orderDate,
    required this.userId,
    required this.totalAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'order_date': orderDate.toIso8601String(),
      'total_amount': totalAmount,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}