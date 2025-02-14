import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/expense_bloc.dart";
import "../bloc/expense_event.dart";
import "../models/user.dart";
import "../widget/app_logo.dart";

class UserSetupPage extends StatefulWidget {
  User? user;
  UserSetupPage({
    super.key,
    this.user,
  });

  @override
  State<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _savingPercentController =
      TextEditingController();
  final TextEditingController _expensePercentController =
      TextEditingController();
  final TextEditingController _pocketPercentController =
      TextEditingController();
  final _savingsController = TextEditingController();
  final _expenseController = TextEditingController();

  String? errText;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    isEdit = widget.user != null;
    if (widget.user != null) _nameController.text = widget.user!.name;
    _savingPercentController.text =
        isEdit ? (widget.user!.savingsPercentage * 100).toString() : "50";
    _expensePercentController.text =
        isEdit ? (widget.user!.expensePercentage * 100).toString() : "40";
    _pocketPercentController.text =
        isEdit ? (widget.user!.pocketMoneyPercentage * 100).toString() : "10";
    _savingsController.text = isEdit ? widget.user!.savingCash.toString() : "0";
    _expenseController.text =
        isEdit ? widget.user!.expenseCash.toString() : "0";
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        Theme.of(context).textTheme.displaySmall!.merge(TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 15,
            ));
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppLogo(suffix: isEdit ? "User Update" : "User Setup"),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextFormField(
                      labelText: "Name", controller: _nameController),
                  Text(
                    textAlign: TextAlign.center,
                    "Manage split percentages for savings, expenses, and pockets.",
                    style: textStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTextFormField(
                        small: true,
                        labelText: "Sav in %",
                        keyboardType: TextInputType.number,
                        controller: _savingPercentController,
                      ),
                      _buildTextFormField(
                        small: true,
                        labelText: "Exp in %",
                        keyboardType: TextInputType.number,
                        controller: _expensePercentController,
                      ),
                      _buildTextFormField(
                        small: true,
                        labelText: "Pok in %",
                        keyboardType: TextInputType.number,
                        controller: _pocketPercentController,
                      ),
                    ],
                  ),
                  if (errText != null)
                    Text(
                      errText as String,
                      textAlign: TextAlign.center,
                      style: textStyle!.merge(
                        TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  if (isEdit) Text("Wallet Info", style: textStyle),
                  // * User can edit saving and expense cash only in edit mode not on setup
                  if (isEdit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTextFormField(
                          small: true,
                          labelText: "Savings Cash",
                          controller: _savingsController,
                          keyboardType: TextInputType.number,
                        ),
                        _buildTextFormField(
                            small: true,
                            labelText: "Expense Cash",
                            controller: _expenseController,
                            keyboardType: TextInputType.number),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.onPrimary,
          ),
          foregroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.primary,
          ),
        ),
        onPressed: () {
          setState(() {
            errText = null;
          });
          double s = double.parse(_savingPercentController.text);
          double e = double.parse(_expensePercentController.text);
          double p = double.parse(_pocketPercentController.text);
          if (_key.currentState!.validate() && (s + e + p) == 100) {
            User user = User(
              id: isEdit ? widget.user!.id : 0,
              name: _nameController.text,
              savingsPercentage: s / 100,
              expensePercentage: e / 100,
              pocketMoneyPercentage: p / 100,
              savingCash: double.parse(_savingsController.text),
              expenseCash: double.parse(_expenseController.text),
            );
            context.read<ExpenseBloc>().add(
                  isEdit ? EditUser(user: user) : SetupUser(user: user),
                );
            Navigator.of(context).pop();
          } else if ((s + e + p) != 100) {
            double total = s + e + p;
            setState(() {
              errText =
                  "The sum of percentages: $total is ${total > 100 ? "over" : "under"} 100. The sum must be 100 to proceed.";
            });
          }
        },
        child: Text(isEdit ? "Update" : "Begin"),
      ),
    );
  }

  Widget _buildTextFormField({
    bool small = false,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: small ? MediaQuery.of(context).size.width * .3 : double.infinity,
        child: TextFormField(
          style: Theme.of(context).textTheme.displaySmall!.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.displaySmall!.merge(
                  TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          maxLength: keyboardType == TextInputType.number ? 3 : 12,
          buildCounter: (BuildContext context,
                  {required int currentLength,
                  required int? maxLength,
                  required bool isFocused}) =>
              Container(),
          keyboardType: keyboardType,
          validator: (String? value) {
            if (value == "" || value == null) {
              return "this field is required";
            }
            return null;
          },
        ),
      ),
    );
  }
}
