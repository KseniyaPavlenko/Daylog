import 'package:daylog/models/day_of_week.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class DayOfWeekSelector extends StatelessWidget {
  const DayOfWeekSelector({
    Key? key,
    required this.selected,
    required this.onTapDay,
    required this.onTapEveryDay,
  }) : super(key: key);

  final List<DayOfWeek> selected;
  final void Function(DayOfWeek) onTapDay;
  final VoidCallback onTapEveryDay;

  bool get isSelectedEveryDay => selected.length == DayOfWeek.values.length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Wrap(
        spacing: 8,
        children: [
          _DayOfWeekItem(
            onTap: onTapEveryDay,
            title: 'Every day',
            isSelected: isSelectedEveryDay,
          ),
          ...List.generate(DayOfWeek.values.length, (index) {
            final item = DayOfWeek.values[index];
            return _DayOfWeekItem(
              onTap: () => onTapDay(item),
              title: item.name,
              isSelected: selected.contains(item) || isSelectedEveryDay,
            );
          })
        ],
      ),
    );
  }
}

class _DayOfWeekItem extends StatelessWidget {
  const _DayOfWeekItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.isSelected,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected
            ? colorScheme.primaryContainer
            : colorScheme.secondaryContainer,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(Icons.check, size: 15),
              const SizedBox(width: 4),
            ],
            Text(
              title.capitalize,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
