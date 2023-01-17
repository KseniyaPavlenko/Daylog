import 'package:flutter/material.dart';

class TabBarMaterialWidget extends StatefulWidget {
  const TabBarMaterialWidget({
    Key? key,
    required this.index,
    required this.onChangedTab,
  }) : super(key: key);
  final int index;
  final ValueChanged<int> onChangedTab;
  @override
  State<TabBarMaterialWidget> createState() => _TabBarMaterialWidgetState();
}

class _TabBarMaterialWidgetState extends State<TabBarMaterialWidget> {
  @override
  Widget build(BuildContext context) {
    const placeholder = Opacity(
        opacity: 0,
        child: IconButton(onPressed: null, icon: Icon(Icons.no_cell)));

    return BottomAppBar(
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(
            index: 0,
            icon: const Icon(Icons.dashboard_outlined),
          ),
          buildTabItem(
            index: 1,
            icon: const Icon(Icons.date_range_outlined),
          ),
          placeholder,
          buildTabItem(
            index: 2,
            icon: const Icon(Icons.description_outlined),
          ),
          buildTabItem(
            index: 3,
            icon: const Icon(Icons.settings_applications_outlined),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({required int index, required Icon icon}) {
    final isSelected = index == widget.index;
    return IconTheme(
      data: IconThemeData(
        color: isSelected ? Colors.white : Colors.black,
      ),
      child: IconButton(
        icon: icon,
        onPressed: () => widget.onChangedTab(index),
      ),
    );
  }
}
