import "package:expense/bloc/expense_bloc.dart";
import "package:expense/bloc/expense_event.dart";
import "package:expense/models/user.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

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
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
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
                TextFormField(
                  controller: nameController,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .merge(textColor),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .merge(textColor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      User updatedUser = User(
                        id: widget.user.id,
                        name: nameController.text,
                        expenseCash: widget.user.expenseCash,
                        pocketCash: widget.user.pocketCash,
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
}
