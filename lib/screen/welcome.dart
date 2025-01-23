import "package:expense/screen/user_setup.dart";
import "package:expense/widget/app_logo.dart";
import "package:flutter/material.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: AppLogo(),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 20,
          left: 8,
          right: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Manage Your Cash Split And Item Purchase",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "50% of your cash in to saving and 40% to expense for buying Items and 10% to pocket. \nUse it properly and I hope it helps.",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        child: Text(
          "NEXT",
          style: Theme.of(context).textTheme.displaySmall!.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const UserSetupPage(),
          ),
        ),
      ),
    );
  }
}
