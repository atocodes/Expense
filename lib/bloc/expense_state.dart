import 'package:expense/models/item.dart';
import 'package:expense/models/log.dart';
import 'package:expense/models/user.dart';
import 'package:objectbox/objectbox.dart';

abstract class ExpenseState {
  final Box<User> user;
  final Box<Item> items;
  final Box<Log> logs;
  Exception? error;

  ExpenseState({
    required this.user,
    required this.items,
    this.error,
    required this.logs,
  });
}

class InitalAppState extends ExpenseState {
  InitalAppState({
    required super.user,
    required super.items,
    required super.logs,
  });
}

class ConfiguredAppState extends ExpenseState {
  ConfiguredAppState({
    required super.user,
    required super.items,
    required super.logs,
  });
}

class UpdateAppState extends ExpenseState {
  UpdateAppState({
    required super.user,
    required super.items,
    required super.logs,
  });
}

class ErrorAppState extends ExpenseState {
  ErrorAppState({
    required super.user,
    required super.items,
    required super.error,
    required super.logs,
  });
}
