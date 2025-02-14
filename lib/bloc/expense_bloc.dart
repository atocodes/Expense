import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox/objectbox.dart';

import '../models/item.dart';
import '../models/log.dart';
import '../models/user.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final Box<User> user;
  final Box<Item> items;
  final Box<Log> logs;
  final Store store;
  // final Box<Log> logs;

  ExpenseBloc({required this.store})
      : user = Box<User>(store),
        items = Box<Item>(store),
        logs = Box<Log>(store),
        super(
          store.box<User>().getAll().isEmpty
              ? InitalAppState(
                  items: Box<Item>(store),
                  user: Box<User>(store),
                  logs: Box<Log>(store),
                )
              : ConfiguredAppState(
                  items: Box<Item>(store),
                  user: Box<User>(store),
                  logs: Box<Log>(store),
                ),
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
    on<ClearLogs>(_clearLogs);
  }

  void _setupUser(SetupUser event, Emitter<ExpenseState> emit) {
    state.user.put(event.user);
    emit(ConfiguredAppState(
      user: state.user,
      items: state.items,
      logs: state.logs,
    ));
  }

  void _editUser(EditUser event, Emitter<ExpenseState> emit) {
    state.user.put(event.user);
    emit(UpdateAppState(
      user: state.user,
      items: state.items,
      logs: state.logs,
    ));
  }

  void _cashIn(CashIn event, Emitter<ExpenseState> emit) {
    if (event.cash == 0) {
      emit(
        ErrorAppState(
          user: state.user,
          items: state.items,
          error: Exception("${event.cash} can not be added to your wallet"),
          logs: state.logs,
        ),
      );
      emit(UpdateAppState(
        user: state.user,
        items: state.items,
        logs: state.logs,
      ));
    } else {
      User user = state.user.getAll().first;
      user.savingCash += event.cash * user.savingsPercentage;
      user.expenseCash += (event.cash) * user.expensePercentage;
      user.pocketCash += (event.cash) * user.pocketMoneyPercentage;
      state.user.put(user);
      // ? add log data to database
      state.logs.put(Log(
        time: DateTime.now(),
        logType: LogType.cashIn.index,
        data: jsonEncode(Cash.calculate(event.cash,user: user).toMap()),
      ));
      emit(UpdateAppState(
        user: state.user,
        items: state.items,
        logs: state.logs,
      ));
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
          logs: state.logs,
        ),
      );
      emit(UpdateAppState(
        user: state.user,
        items: state.items,
        logs: state.logs,
      ));
    } else {
      user.savingCash -= event.cash;
      user.expenseCash += (event.cash) * (user.expensePercentage + user.savingsPercentage);
      user.pocketCash += (event.cash) * user.savingsPercentage;
      state.user.put(user);
      state.logs.put(Log(
        time: DateTime.now(),
        logType: LogType.cashTransfer.index,
        data: jsonEncode(
            Cash.calculate(event.cash, transfer: true,user: user).toMap(transfer: true)),
      ));
      emit(UpdateAppState(
        user: state.user,
        items: state.items,
        logs: state.logs,
      ));
    }
  }

  void _removeUser(RemoveUser event, Emitter<ExpenseState> emit) {
    state.user.remove(event.user.id);
    emit(InitalAppState(
      user: state.user,
      items: state.items,
      logs: state.logs,
    ));
  }

  void _addItem(AddItem event, Emitter<ExpenseState> emit) {
    event.item.user.target = state.user.getAll().first;
    state.items.put(event.item);
    emit(UpdateAppState(
      user: state.user,
      items: state.items,
      logs: state.logs,
    ));
  }

  void _buyItem(ItemPurchase event, Emitter<ExpenseState> emit) {
    User user = state.user.getAll().first;
    CashType cashType = event.item.cashTypeEnum;
    if (cashType == CashType.xpense &&
            event.item.total > user.expenseCash &&
            !event.item.purchased ||
        // cashType == CashType.pocket &&
        //     event.item.total > user.pocketCash &&
        //     !event.item.purchased ||
        cashType == CashType.saving &&
            event.item.total > user.savingCash &&
            !event.item.purchased) {
      emit(
        ErrorAppState(
          user: state.user,
          items: state.items,
          error: Exception(event.item.purchased
              ? "Item Purchased"
              : "Can Not Make Purchase , Not Enough Cash In ${cashType.name.toUpperCase()}..."),
          logs: state.logs,
        ),
      );
      emit(UpdateAppState(
        user: state.user,
        items: state.items,
        logs: state.logs,
      ));
    } else {
      if (!event.item.purchased) {
        event.item.purchasedDate = DateTime.now();
      }

      switch (event.item.cashTypeEnum) {
        case CashType.xpense:
          event.item.purchased
              ? user.expenseCash += event.item.price
              : user.expenseCash -= event.item.price;
          break;
        // case CashType.pocket:
        //   event.item.purchased
        //       ? user.pocketCash += event.item.price
        //       : user.pocketCash -= event.item.price;
        //   break;
        case CashType.saving:
          event.item.purchased
              ? user.savingCash += event.item.price
              : user.savingCash -= event.item.price;
          break;
      }

      event.item.purchased = !event.item.purchased;
      state.items.put(event.item);
      state.user.put(user);
      // TODO : Add Purchase log
      emit(UpdateAppState(
        user: state.user,
        items: state.items,
        logs: state.logs,
      ));
    }
  }

  void _editItem(EditItem event, Emitter<ExpenseState> emit) {
    event.item.user.target = state.user.getAll().first;
    state.items.put(event.item);
    emit(UpdateAppState(
      user: state.user,
      items: state.items,
      logs: state.logs,
    ));
  }

  void _removeItem(RemoveItem event, Emitter<ExpenseState> emit) {
    state.items.remove(event.item.id);
    emit(UpdateAppState(
      user: state.user,
      items: state.items,
      logs: state.logs,
    ));
  }

  // reset event controllers
  void _resetApp(ResetApp event, Emitter<ExpenseState> emit) {
    state.user.removeAll();
    state.items.removeAll();
    emit(InitalAppState(
      items: state.items,
      user: state.user,
      logs: state.logs,
    ));
  }

  void _resetItems(ResetItems event, Emitter<ExpenseState> emit) {
    state.items.removeAll();
    emit(UpdateAppState(
      user: state.user,
      items: state.items,
      logs: state.logs,
    ));
  }

  void _resetUser(ResetUser event, Emitter<ExpenseState> emit) {
    User user = state.user.getAll().first;
    user.totalCash = 0;
    user.savingCash = 0;
    user.pocketCash = 0;
    user.expenseCash = 0;
    state.user.put(user);
    state.logs.removeAll();
    emit(UpdateAppState(
      user: state.user,
      items: state.items,
      logs: state.logs,
    ));
  }

  void _clearLogs(ClearLogs event, Emitter<ExpenseState> emit) {
    state.logs.removeAll();
    emit(UpdateAppState(
      user: state.user,
      items: state.items,
      logs: state.logs,
    ));
  }
}
