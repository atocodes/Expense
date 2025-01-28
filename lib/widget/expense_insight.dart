import "package:expense/models/item.dart" show CashType;
import "package:expense/models/user.dart";
import "package:flutter/material.dart";

class ExpenseInsight extends StatelessWidget {
  final User user;
  const ExpenseInsight({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "${percent()['spent']}Br",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  "Spent",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "${user.expenseCash}/${percent()['budget']}Br",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  "Budget",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: double.infinity,
              height: 10,
            ),
            Container(
              color: Theme.of(context).colorScheme.onPrimary,
              height: 10,
              width: MediaQuery.of(context).size.width *
                  (percent()['percent']! / 100),
            ),
          ],
        )
      ],
    );
  }

  Map<String, double> percent() {
    double totalCash = 0;
    double expenseCash = user.expenseCash;
    for (var item in user.items) {
      if (item.purchased && item.cashTypeEnum == CashType.expense) {
        totalCash += item.price;
        expenseCash += item.price;
      }
    }

    double totalPercent = (totalCash / expenseCash) * 100;
    return {
      "spent": totalCash,
      "budget": expenseCash,
      "percent": totalPercent.isNaN ? 0 : totalPercent,
    };
    // return totalPercent;
  }
}
