import "package:expense/modal_sheets/new_item.dart";
import "package:expense/models/item.dart";
import "package:expense/models/user.dart";
import "package:expense/theme/theme_data.dart";
import "package:expense/widget/curved_list_tile.dart";
import "package:flutter/material.dart";

class ItemList extends StatefulWidget {
  User user;

  ItemList({super.key, required this.user});
  // List<Item> items;
  // double cash;

  // ItemList({
  //   super.key,
  //   required this.items,
  //   required this.cash,
  // });
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late final PageController _pageController;
  List<Item> items = [];
  bool listAll = true;
  CashType? listType;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    items = widget.user.items;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .42,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${listType?.name.toUpperCase() ?? "ALL"} ITEMS",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                if (listType != null)
                  TextButton.icon(
                    label: Text(
                      listAll ? "Sort By Affordable" : "List All",
                    ),
                    icon: const Icon(Icons.sort),
                    onPressed: () => setState(() {
                      listAll = !listAll;
                      items = listType == null
                          ? widget.user.items
                          : Item.affordableItems(
                              items,
                              widget.user.toMap()["${listType!.name}Cash"],
                            );
                    }),
                  ),
                _buildSigmentButtons(),
              ],
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
      ),
    );
  }

  Widget _buildSigmentButtons() {
    return SegmentedButton<CashType?>(
      emptySelectionAllowed: true,
      style: Theme.of(context).elevatedButtonTheme.style!.merge(greenBtnStyle),
      showSelectedIcon: true,
      selectedIcon: Icon(
        Icons.check_box_rounded,
        size: 25,
        color: Theme.of(context).colorScheme.secondary,
      ),
      segments: CashType.values
          .map((CashType value) => ButtonSegment(
                value: value,
                icon: const Icon(Icons.monetization_on),
                label: Text(value.name.toUpperCase()),
              ))
          .toList(),
      selected: <CashType?>{listType},
      onSelectionChanged: (value) => setState(() {
        if (value.isEmpty) {
          items = widget.user.items;
        } else {
          items = Item.filter(widget.user.items, value.first as CashType);
        }

        listType = value.isEmpty ? null : value.first;
      }),
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
                    _pageController.nextPage(duration: duration, curve: curve);
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
