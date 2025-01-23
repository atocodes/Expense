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
    on<CashIn>(_cashIn);
    on<CashTransfer>(_cashTransfer);
    on<RemoveUser>(_removeUser);
    on<AddItem>(_addItem);
    on<EditItem>(_editItem);
    on<ItemPurchase>(_buyItem);
    on<RemoveItem>(_removeItem);
    on<ResetApp>(_resetApp);
    on<ResetItems>(_resetItems);
    on<ResetUser>(_resetUser);
  }

  void _setupUser(SetupUser event, Emitter<ExpenseState> emit) {
    state.user.put(event.user);
    emit(ConfiguredAppState(user: state.user, items: state.items));
  }

  void _editUser(EditUser event, Emitter<ExpenseState> emit) {
    state.user.put(event.user);
    emit(UpdateAppState(user: state.user, items: state.items));
  }

  void _cashIn(CashIn event, Emitter<ExpenseState> emit) {
    if (event.cash == 0) {
      emit(
        ErrorAppState(
          user: state.user,
          items: state.items,
          error: Exception("${event.cash} can not be added to your wallet"),
        ),
      );
      emit(UpdateAppState(user: state.user, items: state.items));
    } else {
      User user = state.user.getAll().first;
      user.totalCash += event.cash;
      user.savingCash += event.cash * .5;
      user.expenseCash += (event.cash) * .4;
      user.pocketCash += (event.cash) * .1;
      state.user.put(user);
      emit(UpdateAppState(user: state.user, items: state.items));
    }
  }

  void _cashTransfer(CashTransfer event, Emitter<ExpenseState> emit) {
    User user = state.user.getAll().first;

    if (event.cash > user.savingCash) {
      emit(
        ErrorAppState(
          user: state.user,
          items: state.items,
          error: Exception("Your Saving Does Not Have That Amount Of Cash"),
        ),
      );
      emit(UpdateAppState(user: state.user, items: state.items));
    }else{
      user.savingCash -= event.cash;
      user.expenseCash += (event.cash) * .4;
      user.pocketCash += (event.cash) * .1;
      state.user.put(user);
      emit(UpdateAppState(user: state.user, items: state.items));
    }
  }

  void _removeUser(RemoveUser event, Emitter<ExpenseState> emit) {
    state.user.remove(event.user.id);
    emit(InitalAppState(user: state.user, items: state.items));
  }

  void _addItem(AddItem event, Emitter<ExpenseState> emit) {
    event.item.user.target = state.user.getAll().first;
    state.items.put(event.item);
    emit(UpdateAppState(user: state.user, items: state.items));
  }

  void _buyItem(ItemPurchase event, Emitter<ExpenseState> emit) {
    User user = state.user.getAll().first;

    if (event.item.price > user.expenseCash && event.item.purchased == false) {
      emit(
        ErrorAppState(
          user: state.user,
          items: state.items,
          error: Exception("Can Not Make Purchase , Not Enough Cash..."),
        ),
      );
      emit(UpdateAppState(user: state.user, items: state.items));
    } else {
      if (!event.item.purchased) {
        event.item.purchasedDate = DateTime.now();
        user.expenseCash -= event.item.price;
      } else {
        user.expenseCash += event.item.price;
      }
      event.item.purchased = !event.item.purchased;
      state.items.put(event.item);
      state.user.put(user);
      emit(UpdateAppState(user: state.user, items: state.items));
    }
  }

  void _editItem(EditItem event, Emitter<ExpenseState> emit) {
    event.item.user.target = state.user.getAll().first;
    state.items.put(event.item);
    emit(UpdateAppState(user: state.user, items: state.items));
  }

  void _removeItem(RemoveItem event, Emitter<ExpenseState> emit) {
    state.items.remove(event.item.id);
    emit(UpdateAppState(user: state.user, items: state.items));
  }

  // reset event controllers
  void _resetApp(ResetApp event, Emitter<ExpenseState> emit) {
    state.user.removeAll();
    state.items.removeAll();
    emit(InitalAppState(items: state.items, user: state.user));
  }

  void _resetItems(ResetItems event, Emitter<ExpenseState> emit) {
    state.items.removeAll();
    emit(UpdateAppState(user: state.user, items: state.items));
  }

  void _resetUser(ResetUser event, Emitter<ExpenseState> emit) {
    User user = state.user.getAll().first;
    user.totalCash = 0;
    user.savingCash = 0;
    user.pocketCash = 0;
    user.expenseCash = 0;
    state.user.put(user);
    emit(UpdateAppState(user: state.user, items: state.items));
  }
}
