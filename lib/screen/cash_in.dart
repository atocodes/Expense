import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/expense_bloc.dart";
import "../bloc/expense_event.dart";
import "../models/user.dart";
import "../widget/app_logo.dart";
import "../widget/navs.dart";

class CashInPage extends StatefulWidget {
  final User user;
  final PageController pageController;
  const CashInPage({
    super.key,
    required this.user,
    required this.pageController,
  });

  @override
  State<CashInPage> createState() => _CashInPageState();
}

class _CashInPageState extends State<CashInPage> {
  List<String> value = [];
  bool transfer = false;

  void _eraseValue() => setState(() {
        value.clear();
      });

  void _changeTransfer() => setState(() {
        transfer = !transfer;
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _changeTransfer,
          child: AppLogo(
            suffix: transfer ? "TRANSFER" : "CASH IN",
          ),
        ),
        actions: [
          AppNav(
            pageController: widget.pageController,
            onPage: OnPage.cashIn,
          ),
          IconButton(
            icon: Icon(
              Icons.currency_exchange_outlined,
              color: transfer
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.secondary,
            ),
            onPressed: _changeTransfer,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(
            double.infinity,
            MediaQuery.of(context).size.height * .05,
          ),
          child: Text(
            textAlign: TextAlign.center,
            "Current Cash Status \n Saving: ${widget.user.savingCash.toStringAsFixed(2)}Br | Expense : ${widget.user.expenseCash.toStringAsFixed(2)}Br | \nPocket : ${widget.user.pocketCash.toStringAsFixed(2)}Br",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * .3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (value.isNotEmpty)
                  _buildCashInfo(
                    Cash.calculate(
                      double.parse(value.join()),
                      transfer: transfer,
                    ),
                  ),
                Text(
                  "${value.isEmpty ? "0" : value.join()} Br",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height * .6,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    3,
                    (int rowIndex) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(3, (int columnIndex) {
                          int buttonValue = rowIndex * 3 + columnIndex + 1;
                          return buildKeyboardButton(buttonValue.toString());
                        }),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildKeyboardButton("."),
                      buildKeyboardButton("0"),
                      buildKeyboardButton("X", erase: true)
                    ],
                  ),
                  _buildButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    double cash = double.parse(value.isEmpty ? "0" : value.join());
    bool canNotBeTransfered = double.parse(value.isEmpty ? "0" : value.join()) >
        widget.user.savingCash;
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .06,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            value.isEmpty
                ? Theme.of(context).colorScheme.primary
                : transfer && canNotBeTransfered
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
          ),
        ),
        onLongPress: _changeTransfer,
        onPressed: transfer && canNotBeTransfered || 0 >= cash
            ? null
            : () {
                context.read<ExpenseBloc>().add(
                      transfer ? CashTransfer(cash: cash) : CashIn(cash: cash),
                    );
                _eraseValue();
              },
        child: Text(
          textAlign: TextAlign.center,
          transfer
              ? canNotBeTransfered
                  ? "INSUFFCIENT SAVING, CANT TRANSFER"
                  : "TRANSFER TO EXPENSE"
              : "CASH IN",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }

  Widget _buildCashInfo(Cash cash) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: [
        Text(
          "${transfer ? "-" : "+"}${cash.savingCash}${cash.savingCash < 1 ? "Cent" : "Br"} SvC",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(width: 10),
        Text(
          "+${cash.expenseCash}${cash.expenseCash < 1 ? "Cent" : "Br"} ExC",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(width: 10),
        Text(
          "+${cash.pocketCash}${cash.pocketCash < 1 ? "Cent" : "Br"} PoC",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }

  Widget buildKeyboardButton(String content, {bool erase = false}) {
    TextStyle textColor = TextStyle(
      color: Theme.of(context).colorScheme.primary,
    );

    return GestureDetector(
      onTap: () => setState(
        () {
          if (erase && value.isNotEmpty) {
            value.removeLast();
            return;
          }
          if (content != "X") value.add(content);
        },
      ),
      onLongPress: erase ? _eraseValue : null,
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * .02),
        height: MediaQuery.of(context).size.width * .2,
        width: MediaQuery.of(context).size.width * .2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(25),
        ),
        child: erase
            ? const Icon(Icons.backspace)
            : Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge!.merge(textColor),
              ),
      ),
    );
  }
}
