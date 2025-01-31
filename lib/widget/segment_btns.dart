import "package:flutter/material.dart";

import "../theme/theme_data.dart";

class SegmentBtns<T> extends StatefulWidget {
  final List<T?> segments;
  bool emptySelection;
  final T? selected;
  final void Function(Set<T?>) updateSelection;

  SegmentBtns({
    super.key,
    required this.segments,
    this.emptySelection = true,
    required this.selected,
    required this.updateSelection,
  });

  @override
  State<SegmentBtns<T>> createState() => _SegmentBtnsState<T>();
}

class _SegmentBtnsState<T> extends State<SegmentBtns<T>> {
  T? selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<T?>(
        emptySelectionAllowed: widget.emptySelection,
        style:
            Theme.of(context).elevatedButtonTheme.style!.merge(greenBtnStyle),
        showSelectedIcon: true,
        selectedIcon: Icon(
          Icons.check_box_rounded,
          size: 25,
          color: Theme.of(context).colorScheme.secondary,
        ),
        segments: widget.segments
            .map((T? value) => ButtonSegment(
                  value: value,
                  icon: const Icon(Icons.monetization_on),
                  label: Text(value
                      .toString()
                      .replaceRange(0, value.toString().indexOf(".") + 1, "")
                      .toUpperCase()),
                ))
            .toList(),
        selected: <T?>{widget.selected},
        onSelectionChanged: widget.updateSelection,
      ),
    );
  }
}
