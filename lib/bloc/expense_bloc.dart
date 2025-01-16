import 'package:expense/bloc/expense_event.dart';
import 'package:expense/bloc/expense_state.dart';
import 'package:expense/models/item.dart';
import 'package:expense/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox/objectbox.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final Box<User> user;
  final Box<Item> items;

  ExpenseBloc({required this.user, required this.items})
      : super(
          user.getAll().isEmpty
              ? InitalAppState(items: items, user: user)
              : ConfiguredAppState(items: items, user: user),
        ) {
    on<SetupUser>(_setupUser);
    on<EditUser>(_editUser);
    on<RemoveUser>(_removeUser);
    on<AddItem>(_addItem);
    on<EditItem>(_editItem);
    on<RemoveItem>(_removeItem);
  }

  void _setupUser(SetupUser event, Emitter<ExpenseState> emit) {
    state.user.put(event.user);
    emit(ConfiguredAppState(user: state.user, items: state.items));
  }

  void _editUser(EditUser event, Emitter<ExpenseState> emit) {
    state.user.put(event.user);
    emit(UpdateAppState(user: state.user, items: state.items));
  }

  void _removeUser(RemoveUser event, Emitter<ExpenseState> emit) {
    state.user.remove(event.user.id);
    emit(InitalAppState(user: state.user, items: state.items));
  }

  void _addItem(AddItem event, Emitter<ExpenseState> emit) {
    state.items.put(event.item);
    emit(UpdateAppState(user: state.user, items: state.items));
  }

  void _editItem(EditItem event, Emitter<ExpenseState> emit) {
    state.items.put(event.item);
    emit(UpdateAppState(user: state.user, items: state.items));
  }

  void _removeItem(RemoveItem event, Emitter<ExpenseState> emit) {
    state.items.remove(event.item.id);
    emit(UpdateAppState(user: state.user, items: state.items));
  }
}
