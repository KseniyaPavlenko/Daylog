import 'package:flutter/material.dart';

const _bottomBarIcons = [
  Icons.dashboard_outlined,
  Icons.date_range_outlined,
  Icons.add,
  Icons.info_outline,
  Icons.settings_applications_outlined,
];

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
    // TODO(Kseniya): удали
    // const placeholder = Opacity(
    //     opacity: 0,
    //     child: IconButton(onPressed: null, icon: Icon(Icons.no_cell)));

    return BottomNavigationBar(
      items: List.generate(
        _bottomBarIcons.length,
        (index) {
          final icon = _bottomBarIcons[index];
          return BottomNavigationBarItem(
            icon: Icon(icon),
            label: icon.toString(),
          );
        },
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
