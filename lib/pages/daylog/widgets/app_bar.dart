import 'package:daylog/common/route/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.automaticallyImplyLeading,
    this.leadingWidth,
    this.leading,
    this.title,
    this.backgroundColor,
    this.centerTitle,
    this.actions, this.onTap,
  }) : super(key: key);

  final bool automaticallyImplyLeading;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final Color? backgroundColor;
  final bool? centerTitle;
  final List<Widget>? actions;
  final void onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // TODO(Kseniya): вынеси в отдельный файл
      automaticallyImplyLeading: false,
      leadingWidth: 100,
      leading: ElevatedButton.icon(
        onPressed: () => context.go(AppRouter.home),
        icon: const Icon(Icons.arrow_left_sharp),
        label: const Text('Back'),
        style: ElevatedButton.styleFrom(
            elevation: 3,
            primary: Colors.brown[900],
            minimumSize: const Size(1000, 1000)),
      ),
      title: const Text('Day Log'),
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      actions: <Widget>[
        ElevatedButton.icon(
          onPressed: () => onTap,
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save'),
          style: ElevatedButton.styleFrom(
            elevation: 3,
            primary: Colors.brown[900],
          ),
        ),
      ],
    );
  }
}
