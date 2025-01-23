import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  String suffix;
  String prefix;
  bool light;
  AppLogo({
    super.key,
    this.prefix = "",
    this.suffix = "",
    this.light = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicWidth(
        // width: MediaQuery.of(context).size.width * .5,
        child: Row(
          // mainAxisAlignment: alignment,
          children: [
            Icon(
              Icons.monetization_on,
              size: 40,
              color: light
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 5),
            Text(
              "${prefix != "" ? "$prefix's" : ""} Expense $suffix",
              style: Theme.of(context).textTheme.displaySmall!.merge(
                    TextStyle(
                      color: light
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                    ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
