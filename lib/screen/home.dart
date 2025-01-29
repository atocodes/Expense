import "package:expense/modal_sheets/developer_info.dart";
import "package:expense/models/item.dart";
import "package:expense/models/user.dart";
import "package:expense/theme/theme_data.dart";
import "package:expense/widget/app_logo.dart";
import "package:expense/widget/cash_insight.dart";
import "package:expense/widget/items_list.dart";
import "package:expense/widget/navs.dart";
import "package:flutter/material.dart";

class Home extends StatefulWidget {
  final User user;
  final PageController pageController;
  const Home({
    super.key,
    required this.user,
    required this.pageController,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
        actions: [
          TextButton.icon(
            label: const Text("Developer Info"),
            onPressed: () => DeveloperInfo.buildAlertBox(context),
            icon: const Icon(Icons.developer_mode),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "Hello ${widget.user.name} ${[
                  "haset",
                  "ሃሴት",
                  "ሐሴት",
                  "ሀሴት",
                  "ሮማን",
                  'roman',
                ].contains(widget.user.name.toLowerCase()) ? "Thank You For Testing This App የኔ ሃሴት 😘 " : ""}",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Welcome Back !",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            CashInsight(
              expense: widget.user.expenseCash,
              savings: widget.user.savingCash,
              pocketCash: widget.user.pocketCash,
              total: widget.user.totalCash,
              goToCashInPage: () => widget.pageController.jumpToPage(2),
              showMoreCallback: () => widget.pageController.jumpToPage(1),
            ),
            Expanded(
              child: ItemList(user: widget.user),
              // child: ItemList(
              //   items: items,
              //   cash: listType == null
              //       ? 0
              //       : widget.user.toMap()["${listType!.name}Cash"],
              // ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNav(
        pageController: widget.pageController,
        onPage: OnPage.home,
      ),
    );
  }

}