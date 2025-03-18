import 'itemsmodel.dart';

class CartItem {
  final ItemsModel item;

  late int quantity=1;
  late  int unit;

  CartItem({
    required this.item,
    required this.quantity,
    required this.unit,
  });

  // Add copyWith method
  CartItem copyWith({
    ItemsModel? item,
    int? quantity,
    int? unit,
  }) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  num? get itemTotalPrice {
    if (unit == 0) {
      return item.itemPrice! * quantity;
    } else if (unit == 1) {
      return item.itemPriceBox! * quantity;
    }
    return 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': item.itemsId,
      'item_quantity': quantity,
      'item_unit': unit,
      'item_price': unit == 0 ? item.itemPrice : item.itemPriceBox,
      'total_price': itemTotalPrice,
    };
  }
}