import 'package:daylog/common/utils/context_utils.dart';
import 'package:flutter/material.dart';

class CommonScaffold extends StatefulWidget {
  const CommonScaffold({
    Key? key,
    required this.body,
    this.isLoading = false,
    this.error,
    this.bottomBar,
    this.floatButton,
  }) : super(key: key);

  final Widget body;
  final bool isLoading;
  final String? error;
  final Widget? bottomBar;
  final Widget? floatButton;

  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  @override
  void didUpdateWidget(CommonScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.error?.isNotEmpty ?? false) {
      context.showError(widget.error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[700],
      // backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: widget.floatButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          widget.body,
          if (widget.isLoading)
            Container(
              alignment: Alignment.center,
              color: Colors.grey[400],
              child: CircularProgressIndicator(
                color: Colors.grey[850],
              ),
            ),
        ],
      ),
      bottomNavigationBar: widget.bottomBar,
    );
  }
}
