import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/expense_bloc.dart";
import "../bloc/expense_event.dart";
import "../screen/user_setup.dart";
import "../models/user.dart";

class UserOptions extends StatelessWidget {
  User? user;
  UserOptions({super.key, this.user});

  static void buildBottomSheet(BuildContext context, User user) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) => UserOptions(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      // width: double.infinity,
      // height: MediaQuery.of(context).size.height * .12,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Edit User Info"),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => UserSetupPage(user: user),
                ),
              ),
              // onPressed: () => EditProfile.build(context, user as User),
            ),
          ),
          _buildButton(
            context: context,
            event: ResetUser(),
            title: "Reset Cash Data",
            icon: Icons.money_off,
            color: Theme.of(context).colorScheme.error,
          ),
          _buildButton(
            context: context,
            event: ResetItems(),
            title: "Reset Items Data",
            icon: Icons.clear_all,
            color: Theme.of(context).colorScheme.error,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required ExpenseEvent event,
    required String title,
    Color? color,
    IconData? icon,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon ?? Icons.clear),
        label: Text(title),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
          foregroundColor: WidgetStatePropertyAll(
            color != null && color == Colors.red
                ? Theme.of(context).colorScheme.onPrimary
                : color,
          ),
        ),
        onPressed: () => context.read<ExpenseBloc>().add(event),
      ),
    );
  }
}
