import '../models/item.dart';
import '../models/user.dart';

enum CashFrom { expense, pocket }

abstract class ExpenseEvent {}

class SetupUser extends ExpenseEvent {
  final User user;
  SetupUser({required this.user});
}

class EditUser extends ExpenseEvent {
  final User user;
  EditUser({required this.user});
}

class CashIn extends ExpenseEvent {
  final double cash;
  CashIn({required this.cash});
}

class CashTransfer extends ExpenseEvent {
  final double cash;
  CashTransfer({required this.cash});
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

class ItemPurchase extends ExpenseEvent {
  final Item item;
  CashFrom cashFrom;
  ItemPurchase({
    required this.item,
    this.cashFrom = CashFrom.expense,
  });
}

class RemoveItem extends ExpenseEvent {
  final Item item;
  RemoveItem({required this.item});
}

class ResetApp extends ExpenseEvent {}

class ResetItems extends ExpenseEvent {
  ResetItems();
}

class ResetUser extends ExpenseEvent {
  ResetUser();
}

class ClearLogs extends ExpenseEvent {
  ClearLogs();
}
