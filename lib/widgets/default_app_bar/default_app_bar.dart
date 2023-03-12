import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    Key? key,
    this.automaticallyImplyLeading = false,
    this.leadingWidth = 100,
    this.leading,
    required this.title,
    this.backgroundColor,
    this.centerTitle = true,
    this.actions,
  }) : super(key: key);

  final bool automaticallyImplyLeading;
  final double leadingWidth;
  final Widget? leading;
  final String title;
  final Color? backgroundColor;
  final bool centerTitle;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leadingWidth: leadingWidth,
      leading: leading,
      title: Text(title),
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      centerTitle: centerTitle,
      actions: actions,
    );
  }
}

//for daylog page
// ElevatedButton.icon(
//         onPressed: () => context.go(AppRouter.home),
//         icon: const Icon(Icons.arrow_left_sharp),
//         label: const Text('Back'),
//         style: ElevatedButton.styleFrom(
//             elevation: 3,
//             backgroundColor: Colors.brown[900],
//             minimumSize: const Size(1000, 1000)),
//       ),

//const Text('Day Log')

//actions
// <Widget>[
//         ElevatedButton.icon(
//           onPressed: () => onTap,
//           icon: const Icon(Icons.save_outlined),
//           label: const Text('Save'),
//           style: ElevatedButton.styleFrom(
//             elevation: 3,
//             backgroundColor: Colors.brown[900],
//           ),
//         ),
//       ],




// implements PreferredSizeWidget {
//   final Widget child;
//   final double height;

//   CustomAppBar({
//     required this.child,
//     this.height = kToolbarHeight,
//   });

//   @override
//   Size get preferredSize => Size.fromHeight(height);
