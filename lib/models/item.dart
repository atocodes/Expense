import 'package:objectbox/objectbox.dart';

import 'user.dart';

enum SortBy { price, priority }

enum CashType { xpense, pocket, saving }

@Entity()
class Item {
  int id;
  final String name;
  final double price;
  final int quantity;
  final double priority;
  final int cashType;
  double total;

  DateTime? purchasedDate;
  bool purchased = false;

  // relationship
  final user = ToOne<User>();

  Item({
    this.id = 0,
    required this.name,
    required this.price,
    this.purchasedDate,
    this.quantity = 1,
    this.priority = 0,
    this.cashType = 0,
  }) : total = price * quantity;

  CashType get cashTypeEnum {
    return CashType.values[cashType];
  }

  static List<Item> sort(List<Item> items, {SortBy sortBy = SortBy.priority}) {
    // bubble sort algo
    List<Item> items0 = items;
    for (int i = 1; i <= items.length - 1; i++) {
      for (int j = 0; j < items.length - 1; j++) {
        bool condition = sortBy == SortBy.priority
            ? items0[j].priority < items[j + 1].priority
            : items0[j].price < items[j + 1].price;
        if (condition) {
          Item tmp = items0[j];
          items0[j] = items0[j + 1];
          items0[j + 1] = tmp;
        }
      }
    }

    return items0;
  }

  static List<Item> filter(List<Item> items, CashType type) =>
      items.where((Item item) => item.cashTypeEnum == type && !item.purchased).toList();

  static List<Item> affordableItems(List<Item> items, double money,
      {SortBy sortBy = SortBy.priority, CashType cashType = CashType.xpense}) {
    List<Item> afforableItems = [];
    List<Item> sortedItems = Item.sort(
      items,
      sortBy: sortBy,
    );
    double cash = money;
    for (Item item in sortedItems) {
      if (cash >= item.total &&
          !item.purchased &&
          item.cashTypeEnum == cashType) {
        afforableItems.add(item);
        cash -= item.total;
      }
      continue;
    }

    return afforableItems;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'priority': priority,
      'cashType': CashType.values[cashType].name,
      'total': total,
    };
  }
}
