
import "package:flutter/material.dart";

import "../modal_sheets/user_options.dart";
import "../models/item.dart";
import "../models/user.dart";
import "../widget/app_logo.dart";
import "../widget/xpense_insight.dart";
import "../widget/item_list_tile.dart";
import "../widget/navs.dart";
import "logs_screen.dart";

class XpenseInsightPage extends StatelessWidget {
  final User user;
  final PageController pageController;
  const XpenseInsightPage({
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
          TextButton.icon(
            icon: const Icon(Icons.history),
            label: const Text("Logs"),
            onPressed: () =>
                Navigator.of(context).pushNamed(LogsScreen.routeName),
          ),
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
            XpenseInsight(user: user),
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
                      .map((Item item) => ItemListTile(item: item))
                      .toList().cast<Widget>(),
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
