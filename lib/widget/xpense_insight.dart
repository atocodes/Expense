import "package:flutter/material.dart";

import "../models/item.dart";
import "../models/user.dart";

class XpenseInsight extends StatelessWidget {
  final User user;
  const XpenseInsight({super.key, required this.user});

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
                  "${percent()['spent']!.toStringAsFixed(1)}Br",
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
                  "${user.expenseCash.toStringAsFixed(1)}/${percent()['budget']!.toStringAsFixed(1)}Br",
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
    double xpenseCash = user.expenseCash;
    for (var item in user.items) {
      if (item.purchased && item.cashTypeEnum == CashType.xpense) {
        totalCash += item.price;
        xpenseCash += item.price;
      }
    }

    double totalPercent = (totalCash / xpenseCash) * 100;
    return {
      "spent": totalCash,
      "budget": xpenseCash,
      "percent": totalPercent.isNaN ? 0 : totalPercent,
    };
    // return totalPercent;
  }
}
