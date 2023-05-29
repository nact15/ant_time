import 'package:ant_time_flutter/extensions/localizations_extension.dart';
import 'package:flutter/material.dart';

class FilterContextMenu extends StatelessWidget {
  final List<String> title;
  final String initialValue;

  const FilterContextMenu({
    Key? key,
    required this.initialValue,
    this.title = const [
      'title',
      'title',
      'title',
      'title',
      'title',
      'title',
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      height: 48,
      child: PopupMenuButton(
        enableFeedback: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              Text(
                context.localizations.selectProject,
              ),
            ],
          ),
        ),
        tooltip: context.localizations.selectProject,
        itemBuilder: (_) => title
            .map(
              (title) => const PopupMenuItem<String>(
                child: Text('title'),
              ),
            )
            .toList(),
      ),
    );
  }
}
