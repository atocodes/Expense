import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/expense_bloc.dart";
import "../bloc/expense_event.dart";
import "../models/user.dart";
import "../widget/app_logo.dart";

class UserSetupPage extends StatefulWidget {
  const UserSetupPage({super.key});

  @override
  State<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppLogo(suffix: "User Setup"),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .merge(
                            TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      labelText: "Name",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .merge(
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
                    validator: (String? value) {
                      if (value == "" || value == null) {
                        return "this field is required";
                      }
                      return null;
                    },
                  ),
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
          if (_key.currentState!.validate()) {
            User user = User(name: _nameController.text);
            context.read<ExpenseBloc>().add(SetupUser(user: user));
            Navigator.of(context).pop();
          }
        },
        child: const Text("Begin"),
      ),
    );
  }
}
