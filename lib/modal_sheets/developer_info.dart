import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/app_logo.dart';

class DeveloperInfo extends StatefulWidget {
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
  State<DeveloperInfo> createState() => _DeveloperInfoState();
}

class _DeveloperInfoState extends State<DeveloperInfo> {
  final double sigma = 40;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
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
              left: 0,
              child: Text(
                textAlign: TextAlign.center,
                "Thank you for using Xpense app!\nThis is the first release, version 1.0.",
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
                      onPressed: () {
                        _launchInBrowser(
                            Uri.parse('https://www.linkedin.com/in/atocodes/'));
                      },
                      child: const Text("Linked In"),
                    ),
                    TextButton(
                      onPressed: () {
                        _launchInBrowser(
                            Uri.parse('https://github.com/atocodes/'));
                      },
                      child: const Text("Github"),
                    ),
                    TextButton(
                      onPressed: () {
                        _launchInBrowser(
                            Uri.parse('https://www.youtube.com/@atocodes'));
                      },
                      child: const Text("Youtube"),
                    ),
                    TextButton(
                      onPressed: () {
                        _launchInBrowser(Uri.parse('https://t.me/atocodes'));
                      },
                      child: const Text("Telegram"),
                    ),
                    TextButton(
                      onPressed: () {
                        _launchInBrowser(
                            Uri.parse('https://www.instagram.com/atocodes'));
                      },
                      child: const Text("Instagram"),
                    ),
                    TextButton(
                      onPressed: () {
                        _launchInBrowser(
                            Uri.parse('https://www.tiktok.com/@atocodes'));
                      },
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
