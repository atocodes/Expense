import "package:expense/modal_sheets/user_options.dart";
import "package:expense/models/item.dart";
import "package:expense/models/user.dart";
import "package:expense/widget/app_logo.dart";
import "package:expense/widget/expense_insight.dart";
import "package:expense/widget/curved_list_tile.dart";
import "package:expense/widget/navs.dart";
import "package:flutter/material.dart";

class ExpenseInsightPage extends StatelessWidget {
  final User user;
  final PageController pageController;
  const ExpenseInsightPage({
    super.key,
    required this.pageController,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(suffix: "Insight"),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            // label: const Text("Edit"),
            onPressed: () => UserOptions.buildBottomSheet(context, user),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpenseInsight(user: user),
            Text(
              "Item Purchase History",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: user.items
                      .where((Item item) => item.purchased)
                      .map((Item item) => CurvedListTile(item: item))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: AppNav(
        pageController: pageController,
        onPage: OnPage.insight,
      ),
    );
  }
}
