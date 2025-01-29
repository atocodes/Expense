import 'package:expense/models/item.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;
  final String name;
  double totalCash; // ? overall amount cash
  double savingCash; // ? 50% untouchable bank saving money
  double expenseCash; // ? 40% money which wil be spent on buying items
  double pocketCash; // ? 10% of the rest

  // Relationship
  @Backlink()
  final items = ToMany<Item>();
  User({
    required this.name,
    this.id = 0,
    this.savingCash = 0,
    this.expenseCash = 0,
    this.pocketCash = 0,
  }) : totalCash = expenseCash + savingCash + pocketCash;

  static double percent({required double total, required double used}) {
    return ((total - used) * total) / 100;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalCash': totalCash,
      'savingCash': savingCash,
      'expenseCash': expenseCash,
      'pocketCash': pocketCash,
    };
  }
}

class Cash {
  double savingCash = 0; // ? 50% untouchable bank saving money
  double expenseCash = 0; // ? 40% money which wil be spent on buying items
  double pocketCash = 0; // ? 10% of the rest
  double? cash = 0;

  Cash({
    required this.savingCash,
    required this.expenseCash,
    required this.pocketCash,
    this.cash,
  });

  static Cash calculate(double amount, {bool transfer = false}) {
    return Cash(
      expenseCash: transfer ? (amount) * .90 : (amount) * .40,
      pocketCash: (amount) * .10,
      savingCash: transfer ? amount : (amount) * .5,
      cash: amount,
    );
  }

  Map<String, dynamic> toMap({bool transfer = false}) {
    return {
      'savingCash': "${transfer ? "-" : "+"}$savingCash",
      'expenseCash': "+$expenseCash",
      'pocketCash': "+$pocketCash",
      'cash': cash,
    };
  }
}
