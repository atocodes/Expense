import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/expense_bloc.dart";
import "../bloc/expense_state.dart";
import "../database/objectbox.g.dart";
import "../modal_sheets/new_item.dart";
import "../models/item.dart";
import "../models/user.dart";
import "item_list_tile.dart";
import "segment_btns.dart";

class ItemList extends StatefulWidget {
  User user;

  ItemList({super.key, required this.user});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late final PageController _pageController;
  List<Item> items = [];
  bool listAll = true;
  CashType? listType;

  List<Item> _allItems() =>
      widget.user.items.where((Item item) => !item.purchased).toList();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    items = _allItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is UpdateAppState) {
          setState(() {
            items =
                state.items.query(Item_.purchased.equals(false)).build().find();
            if (listType != null) {
              items = items
                  .where((Item item) => item.cashTypeEnum == listType)
                  .toList();
            }
          });
        }
      },
      child: SizedBox(
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
                        listAll ? "List Affordable Items" : "List All",
                      ),
                      icon: const Icon(Icons.sort),
                      onPressed: () => setState(() {
                        listAll = !listAll;
                        items = listType == null || listAll == true
                            ? _allItems()
                                .where((Item item) =>
                                    item.cashTypeEnum == listType)
                                .toList()
                            : Item.affordableItems(
                                items,
                                cashType: listType as CashType,
                                widget.user.toMap()[
                                    "${listType!.name == "xpense" ? "expense" : listType!.name}Cash"],
                              );
                      }),
                    ),
                  SegmentBtns<CashType>(
                    segments: CashType.values,
                    selected: listType,
                    updateSelection: (value) => setState(() {
                      if (value.isEmpty) {
                        items = _allItems();
                      } else {
                        items = Item.filter(
                            widget.user.items, value.first as CashType);
                      }

                      listType = value.isEmpty ? null : value.first;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (items.isNotEmpty)
                ...items.map(
                  (Item item) => ItemListTile(item: item),
                )
              else
                GestureDetector(
                  onTap: () => NewItem.build(context, cashType: listType),
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
                          "Start Adding Your ${listType != null ? listType!.name.toUpperCase() : ""} Items Here",
                          style: Theme.of(context).textTheme.displaySmall,
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
