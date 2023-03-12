import 'package:flutter/material.dart';

class Wireframe extends StatelessWidget {
  final String? bgAsset;
  final String? title;
  final Widget body;
  final List<Widget> children;
  final AlignmentGeometry bgAlignment;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final PreferredSizeWidget? appBar;

  const Wireframe({
    Key? key,
    this.bgAsset,
    this.bgAlignment = Alignment.topCenter,
    this.body = const SizedBox.shrink(),
    this.title,
    this.drawer,
    this.backgroundColor,
    this.floatingActionButton,
    this.children = const <Widget>[],
    this.actions,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).colorScheme.background;
    if (title == null && drawer == null) {
      return _buildBody(context);
    } else {
      return Scaffold(
        floatingActionButton: floatingActionButton,
        appBar: appBar ??
            AppBar(
              title: Text(
                title ?? '',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
            ),
        drawer: drawer,
        backgroundColor: bgColor,
        body: _buildBody(context),
      );
    }
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (bgAsset != null)
          SingleChildScrollView(
            child: Stack(
              children: [
                if (bgAsset != null)
                  Image.asset(
                    bgAsset!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                    alignment: bgAlignment,
                  ),
                ...children,
              ],
            ),
          ),
        Material(
          child: Container(color: backgroundColor, child: body),
        ),
      ],
    );
  }
}
