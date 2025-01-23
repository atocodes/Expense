import "package:expense/bloc/expense_bloc.dart";
import "package:expense/bloc/expense_event.dart";
import "package:expense/models/item.dart";
import "package:expense/models/util.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

class NewItem extends StatefulWidget {
  Item? item;
  NewItem({super.key, this.item});

  @override
  State<NewItem> createState() => _NewItemState();

  static void build(BuildContext context, {Item? item}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => NewItem(item: item),
    );
  }
}

class _NewItemState extends State<NewItem> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  double rating = 0;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      Item item = widget.item as Item;
      _nameController.text = item.name;
      _priceController.text = item.price.toString();
      rating = item.priority;
    }
    _quantityController.text = widget.item?.quantity.toString() ?? "1";
  }
// TODO : new item to be creadited from expense or pocket money option
  final double paddingValue = 8.0;
  @override
  Widget build(BuildContext context) {
    TextStyle textColor = TextStyle(color: Theme.of(context).colorScheme.primary);
    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.only(
          left: paddingValue,
          right: paddingValue,
          top: paddingValue,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: Column(
            children: [
              Text(
                "New Item",
                style: Theme.of(context).textTheme.displaySmall!.merge(textColor),
              ),
              TextFormField(
                controller: _nameController,
                style: Theme.of(context).textTheme.displaySmall!.merge(textColor),
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
                validator: Utils.validateInput,
              ),
              TextFormField(
                controller: _quantityController,
                style: Theme.of(context).textTheme.displaySmall!.merge(textColor),
                decoration: const InputDecoration(
                  hintText: "Quantity",
                ),
                validator: Utils.validateInput,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _priceController,
                style: Theme.of(context).textTheme.displaySmall!.merge(textColor),
                decoration: const InputDecoration(
                  hintText: "Price",
                ),
                validator: Utils.validateInput,
                keyboardType: TextInputType.number,
              ),
              Text("$rating% Prioritized"),
              RatingBar.builder(
                initialRating: rating,
                minRating: 0,
                maxRating: 5,
                direction: Axis.horizontal,
                glowRadius: 0,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double value) => setState(() {
                  rating = value;
                }),
              ),
              ElevatedButton(
                onPressed: _addItem,
                child: Text(widget.item != null ? "Edit" : "Add"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addItem() {
    if (_key.currentState!.validate()) {
      Item item = Item(
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        price: double.parse(_priceController.text),
        priority: rating,
      );

      context.read<ExpenseBloc>().add(AddItem(item: item));
      Navigator.of(context).pop();
    }
  }
}
