import 'package:flutter/material.dart';

import '../modal_sheets/new_item.dart';
import '../theme/theme_data.dart';

enum OnPage { home, insight, cashIn }

class AppNav extends StatelessWidget {
  final PageController pageController;
  final OnPage onPage;
  const AppNav({
    super.key,
    required this.pageController,
    required this.onPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (onPage != OnPage.home)
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              pageController.jumpToPage(0);
            },
          ),
        if (onPage == OnPage.home)
          ElevatedButton.icon(
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.add),
            label: const Text("Add Item"),
            onPressed: () => NewItem.build(context),
            style: greenBtnStyle,
          ),
        if (onPage != OnPage.insight)
          IconButton(
            icon: const Icon(Icons.monitor),
            onPressed: () {
              pageController.jumpToPage(1);
            },
          ),
        if (onPage != OnPage.cashIn)
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () {
              pageController.jumpToPage(2);
            },
          ),
      ],
    );
  }
}
