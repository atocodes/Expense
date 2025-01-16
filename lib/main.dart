import "package:expense/bloc/expense_bloc.dart";
import "package:expense/bloc/expense_state.dart";
import "package:expense/database/objectbox.dart";
import "package:expense/models/item.dart";
import "package:expense/models/user.dart";
import "package:expense/screen/home.dart";
import "package:expense/screen/loading.dart";
import "package:expense/screen/welcome.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:objectbox/objectbox.dart";

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  Store store = objectBox.store;
  runApp(
    BlocProvider(
      create: (_) =>
          ExpenseBloc(user: store.box<User>(), items: store.box<Item>()),
      child: const MaterialApp(
        home: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
        if (state is InitalAppState) {
          return const WelcomePage();
        } else if (state is ConfiguredAppState || state is UpdateAppState) {
          return HomePage(
                    user: state.user.getAll().first
                  );
        }
        return Loading();
      }),
    );
  }
}
