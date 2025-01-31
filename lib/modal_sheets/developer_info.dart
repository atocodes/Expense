import 'dart:ui';

import 'package:flutter/material.dart';

import '../widget/app_logo.dart';

class DeveloperInfo extends StatelessWidget {
  final double sigma = 40;
  const DeveloperInfo({super.key});

  static void buildAlertBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const DeveloperInfo();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              child: Opacity(
                opacity: .8,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 8,
                    sigmaY: 8,
                  ),
                  child: Image.asset(
                    "assets/atocodes.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AppLogo(suffix: "By አቶ Codes || MHCDA"),
            Positioned(
              top: MediaQuery.of(context).size.height * .2,
              left: MediaQuery.of(context).size.width * .1,
              child: Text(
                textAlign: TextAlign.center,
                "Thank You For Using My App\n Test v1.5",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .82,
                height: MediaQuery.of(context).size.height * .1,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Linked In"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Github"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Youtube"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Telegram"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Instagram"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Tiktok"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
