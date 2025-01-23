import "package:flutter/material.dart";

class DescriptionContainer extends StatelessWidget {
  final String title;
  final double num;
  // final Color color;
  bool big;
  DescriptionContainer({
    super.key,
    required this.title,
    required this.num,
    // required this.color,
    this.big = false,
  });

  Widget tmp(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * (big ? .3 : .14),
      width: MediaQuery.of(context).size.width * .43,
      decoration: const BoxDecoration(
        color: Colors.red,
        // borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${num}Br",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${num}Br",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
