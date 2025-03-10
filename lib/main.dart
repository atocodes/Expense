import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:objectbox/objectbox.dart";
import "bloc/expense_bloc.dart";
import "bloc/expense_state.dart";
import "database/objectbox.dart";
import "screen/cash_in.dart";
import "screen/xpense_insight_page.dart";
import "screen/home.dart";
import "screen/loading.dart";
import "screen/logs_screen.dart";
import "screen/welcome.dart";
import "theme/theme_data.dart";

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
Store store = objectBox.store;
  runApp(
    BlocProvider(
      create: (_) => ExpenseBloc(store: store),
      child: MaterialApp(
        theme: customTheme,
        home: App(),
        routes: {
          LogsScreen.routeName: (BuildContext context) => const LogsScreen(),
        },
      ),
    ),
  );
}

class App extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is InitalAppState) {
          return const WelcomePage();
        } else if (state is ConfiguredAppState || state is UpdateAppState) {
          return BlocListener<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              if (state is ErrorAppState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error.toString()),
                  ),
                );
              }
            },
            child: PageView(
              controller: _pageController,
              children: [
                Home(
                  user: state.user.getAll().first,
                  pageController: _pageController,
                ),
                XpenseInsightPage(
                  user: state.user.getAll().first,
                  pageController: _pageController,
                ),
                CashInPage(
                  user: state.user.getAll().first,
                  pageController: _pageController,
                ),
              ],
            ),
          );

          // return HomePage(user: state.user.getAll().first);
        }
        return const Loading();
      },
    );
  }
}
