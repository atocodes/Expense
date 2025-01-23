import "package:expense/bloc/expense_bloc.dart";
import "package:expense/bloc/expense_event.dart";
import "package:expense/modal_sheets/new_item.dart";
import "package:expense/models/item.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class CurvedListTile extends StatelessWidget {
  Item item;
// TODO: show if the item can be bought from pocket money or expense
  CurvedListTile({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id.toString()),
      direction:
          item.purchased ? DismissDirection.none : DismissDirection.endToStart,
      onDismissed: item.purchased
          ? null
          : (DismissDirection direction) {
              context.read<ExpenseBloc>().add(RemoveItem(item: item));
            },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Theme.of(context).colorScheme.error,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "REMOVE",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          // color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          trailing: IconButton(
            onPressed: () {
              // TODO : buy from cash pocket money or expense
              context.read<ExpenseBloc>().add(ItemPurchase(item: item));
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                item.purchased
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.secondary,
              ),
            ),
            icon: Icon(
              item.purchased ? Icons.cancel : Icons.shopping_cart,
            ),
            // child: Text("${item.purchased ? "Un-" : ""}Purchase"),
          ),
          title: Text(
            item.name,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          subtitle: Wrap(
            alignment: WrapAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total : ${item.price * item.quantity}Br\t"),
              Text("Price : ${item.price} Br/Item\t"),
              Text("Prioritys : ${item.priority}"),
              if (item.purchased)
                Text("Purchased Date : ${item.purchasedDate.toString()}\t")
            ],
          ),
          onTap: () => NewItem.build(context, item: item),
          onLongPress: () =>
              context.read<ExpenseBloc>().add(RemoveItem(item: item)),
        ),
      ),
    );
  }
}
