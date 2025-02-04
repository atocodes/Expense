import "package:flutter/material.dart";

import "../theme/theme_data.dart";
import "description_container.dart";

class CashInsight extends StatelessWidget {
  final double expense;
  final double savings;
  final double pocketCash;
  final double total;
  final Function() showMoreCallback;
  final Function() goToCashInPage;

  const CashInsight({
    super.key,
    required this.expense,
    required this.savings,
    required this.pocketCash,
    required this.total,
    required this.goToCashInPage,
    required this.showMoreCallback,
  });
  @override
  Widget build(BuildContext context) {
    // BoxDecoration decoration = BoxDecoration(
    //   color: Theme.of(context).colorScheme.onPrimary,
    //   borderRadius: BorderRadius.circular(10),
    // );
    TextStyle textColor =
        TextStyle(color: Theme.of(context).colorScheme.primary);
    double containerWidth = MediaQuery.of(context).size.width;
    BorderRadius borderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    );
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      width: containerWidth,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Xpense Cash",
                style:
                    Theme.of(context).textTheme.titleMedium!.merge(textColor),
              ),
            ],
          ),
          Text(
            "${expense.toStringAsFixed(2)}Br",
            style: Theme.of(context).textTheme.displayLarge!.merge(textColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${savings.toStringAsFixed(2)}Br Savings',
                style: Theme.of(context).textTheme.titleSmall!.merge(textColor),
              ),
              Text(
                '${pocketCash.toStringAsFixed(2)}Br Pocket',
                style: Theme.of(context).textTheme.titleSmall!.merge(textColor),
              ),
              Text(
                '${(expense + pocketCash + savings).toStringAsFixed(2)}Br Total',
                style: Theme.of(context).textTheme.titleSmall!.merge(textColor),
              ),
            ],
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.monetization_on),
            style: greenBtnStyle,
            onPressed: goToCashInPage,
            label: const Text("Add Cash"),
          ),
        ],
      ),
    );
  }

  Widget tmp(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            DescriptionContainer(
              title: "Savings",
              num: savings,
              big: true,
              // color: Theme.of(context).colorScheme.primaryContainer,
            ),
            Column(
              children: [
                DescriptionContainer(
                  title: "Xpense",
                  num: expense,
                  // color: Theme.of(context).colorScheme.primaryContainer,
                ),
                DescriptionContainer(
                  title: "Pocket Cash",
                  num: pocketCash,
                  // color: Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            )
          ],
        ),
        TextButton(
          onPressed: showMoreCallback,
          child: Text(
            "Show More >>",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }
}
