import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/expense_bloc.dart";
import "../bloc/expense_event.dart";
import "../models/user.dart";

class EditProfile extends StatefulWidget {
  final User user;

  const EditProfile({required this.user, super.key});

  static void build(BuildContext context, User user) => showModalBottomSheet(
      context: context, builder: (_) => EditProfile(user: user));

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pocketController = TextEditingController();
  final _expenseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _pocketController.text = widget.user.pocketCash.toString();
    _expenseController.text = widget.user.expenseCash.toString();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textColor =
        TextStyle(color: Theme.of(context).colorScheme.primary);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: IntrinsicHeight(
        child: Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.zero),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _buildFormFiled(
                  controller: _nameController,
                  labelText: "Name",
                  keyboardType: TextInputType.text,
                  miniInput: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFormFiled(
                      controller: _expenseController,
                      labelText: "Expense Cash",
                    ),
                    _buildFormFiled(
                      controller: _pocketController,
                      labelText: "Pocket Cash",
                    ),
                  ],
                ),
                Text(
                  "Savings : ${widget.user.savingCash}",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .merge(textColor),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      User updatedUser = User(
                        id: widget.user.id,
                        name: _nameController.text,
                        expenseCash: double.parse(_expenseController.text),
                        pocketCash: double.parse(_pocketController.text),
                        savingCash: widget.user.savingCash,
                      );

                      context
                          .read<ExpenseBloc>()
                          .add(EditUser(user: updatedUser));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFiled({
    required TextEditingController controller,
    required String labelText,
    bool miniInput = true,
    TextInputType keyboardType = TextInputType.number,
  }) {
    TextStyle textColor =
        TextStyle(color: Theme.of(context).colorScheme.primary);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: miniInput ? 100 : null,
        child: TextFormField(
          controller: controller,
          style: Theme.of(context).textTheme.displaySmall!.merge(textColor),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle:
                Theme.of(context).textTheme.displaySmall!.merge(textColor),
          ),
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $labelText';
            }
            return null;
          },
        ),
      ),
    );
  }
}
