import "package:expense/modal_sheets/new_item.dart";
import "package:expense/models/item.dart";
import "package:expense/widget/curved_list_tile.dart";
import "package:flutter/material.dart";

class ItemList extends StatefulWidget {
  List<Item> items;
  double expense;

  ItemList({
    super.key,
    required this.items,
    required this.expense,
  });
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .42,
      child: PageView(
        controller: _pageController,
        children: [
          _buildScrollView(
            Item.affordableItems(widget.items, widget.expense),
            affordableItems: true,
          ),
          _buildScrollView(widget.items),
        ],
      ),
    );
  }

  Widget _buildScrollView(List<Item> items, {bool affordableItems = false}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                affordableItems ? "Affordable Items" : "All Items",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton.icon(
                iconAlignment:
                    affordableItems ? IconAlignment.end : IconAlignment.start,
                label: Text(
                  affordableItems ? "Next list" : "Previous list",
                ),
                onPressed: () {
                  Duration duration = const Duration(milliseconds: 200);
                  Curve curve = Curves.bounceInOut;
                  if (affordableItems) {
                    _pageController.nextPage(
                        duration: duration, curve:curve);
                  } else {
                    _pageController.previousPage(
                        duration: duration, curve: curve);
                  }
                },
                icon: Icon(
                  affordableItems
                      ? Icons.arrow_forward_ios
                      : Icons.arrow_back_ios,
                ),
              )
            ],
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(height: 10),
          if (items.isNotEmpty)
            ...items.map(
              (Item item) => CurvedListTile(item: item),
            )
          else
            GestureDetector(
              onTap: () => NewItem.build(context),
              child: Container(
                color: Theme.of(context).colorScheme.secondary,
                height: 100,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.emoji_flags,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Start Adding Your Expense Items Here",
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
