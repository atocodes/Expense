import 'package:expense/models/user.dart';
import 'package:objectbox/objectbox.dart';

enum SortBy { price, priority }

@Entity()
class Item {
  int id = 0;
  final String name;
  final double price;
  final int quantity;
  final double priority;
  DateTime? purchasedDate;
  bool purchased = false;

  // relationship
  final user = ToOne<User>();

  Item({
    required this.name,
    required this.price,
    this.purchasedDate,
    this.quantity = 1,
    this.priority = 0,
  });

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

  static List<Item> affordableItems(List<Item> items, double expense,
      {SortBy sortBy = SortBy.priority}) {
    List<Item> afforableItems = [];
    List<Item> sortedItems = Item.sort(
      items,
      sortBy: sortBy,
    );
    double cash = expense;
    for (Item item in sortedItems) {
      if (cash >= item.price && !item.purchased) {
        afforableItems.add(item);
        cash -= item.price;
      }
      continue;
    }

    return afforableItems;
  }
}
