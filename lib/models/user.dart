import 'package:objectbox/objectbox.dart';

import 'item.dart';

@Entity()
class User {
  int id;
  final String name;
  double totalCash; // ? overall amount cash
  double savingCash; // ? 50% untouchable bank saving money
  double expenseCash; // ? 40% money which wil be spent on buying items
  double pocketCash; // ? 10% of the rest
  double savingsPercentage; // Percentage allocated to savings
  double expensePercentage; // Percentage allocated to expenses
  double pocketMoneyPercentage; // Percentage allocated to pocket money

  // Relationship
  @Backlink()
  final items = ToMany<Item>();
  User({
    required this.name,
    this.id = 0,
    this.savingCash = 0,
    this.expenseCash = 0,
    this.pocketCash = 0,
    this.savingsPercentage = .5,
    this.expensePercentage = .4,
    this.pocketMoneyPercentage = .1,
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
      'savingsPercentage': savingsPercentage,
      'expensePercentage': expensePercentage,
      'pocketMoneyPercentage': pocketMoneyPercentage,
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

  static Cash calculate(double amount,
      {bool transfer = false, required User user}) {
        print(user.savingsPercentage + user.expensePercentage);
    return Cash(
      // on transfer the split is going to be a sum of saving and expense percent
      expenseCash: transfer
          ? (amount) * (user.savingsPercentage + user.expensePercentage)
          : (amount) * user.expensePercentage,
      pocketCash: (amount) * user.pocketMoneyPercentage,
      savingCash: transfer ? amount : (amount) * user.savingsPercentage,
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
