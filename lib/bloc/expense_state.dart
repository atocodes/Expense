import 'package:expense/models/item.dart';
import 'package:expense/models/user.dart';
import 'package:objectbox/objectbox.dart';

abstract class ExpenseState {
  final Box<User> user;
  final Box<Item> items;
  Exception? error;

  ExpenseState({required this.user, required this.items,this.error});
}

class InitalAppState extends ExpenseState {
  InitalAppState({required super.user, required super.items});
}

class ConfiguredAppState extends ExpenseState {
  ConfiguredAppState({required super.user, required super.items});
}

class UpdateAppState extends ExpenseState {
  UpdateAppState({required super.user, required super.items});
}

class ErrorAppState extends ExpenseState {
  ErrorAppState({required super.user, required super.items,required super.error});
}
