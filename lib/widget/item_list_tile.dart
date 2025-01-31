import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/expense_bloc.dart";
import "../bloc/expense_event.dart";
import "../modal_sheets/new_item.dart";
import "../models/item.dart";

class ItemListTile extends StatelessWidget {
  Item item;
  ItemListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.name,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Chip(
            label: Text(
                "${item.purchased ? "PAID FROM " : ""} ${item.cashTypeEnum.name.toUpperCase()} CASH ${item.purchased ? "" : "ITEM"}"),
            labelStyle: Theme.of(context)
                .textTheme
                .labelSmall!
                .merge(const TextStyle(fontSize: 8)),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(item.priority),
                side:
                    BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
            color: WidgetStatePropertyAll(
              item.cashType == 0
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
      subtitle: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text("Total : ${item.total}Br\t"),
              Text("Prioritys : ${item.priority}"),
              if (item.purchased)
                Text("Purchased Date : ${item.purchasedDate.toString()}\t")
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    context.read<ExpenseBloc>().add(ItemPurchase(item: item)),
                child: Text(
                  item.purchased ? "Cancle Purchase" : "Purchase",
                  style: Theme.of(context).textTheme.bodySmall!.merge(
                        TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                ),
              ),
              if (!item.purchased)
                TextButton(
                    onPressed: () =>
                        context.read<ExpenseBloc>().add(RemoveItem(item: item)),
                    child: Text(
                      "Remove",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ))
            ],
          ),
          Divider(color: Theme.of(context).colorScheme.onPrimary)
        ],
      ),
      onTap: () => NewItem.build(context, item: item),
      onLongPress: () =>
          context.read<ExpenseBloc>().add(RemoveItem(item: item)),
    );
  }
}
