import 'package:expense/models/item.dart';
import 'package:expense/models/user.dart';

abstract class ExpenseEvent {}

class SetupUser extends ExpenseEvent {
  final User user;
  SetupUser({required this.user});
}

class EditUser extends ExpenseEvent {
  final User user;
  EditUser({required this.user});
}

class RemoveUser extends ExpenseEvent {
  final User user;
  RemoveUser({required this.user});
}

class AddItem extends ExpenseEvent {
  final Item item;
  AddItem({required this.item});
}

class EditItem extends ExpenseEvent {
  final Item item;
  EditItem({required this.item});
}

class RemoveItem extends ExpenseEvent {
  final Item item;
  RemoveItem({required this.item});
}
