import 'package:flutter/material.dart';

class AppLifecycleListener extends StatefulWidget {
  const AppLifecycleListener({
    this.onReturnToApp,
    required this.child,
    super.key,
  });
  final VoidCallback? onReturnToApp;
  final Widget child;
  @override
  State<AppLifecycleListener> createState() => _AppLifecycleListenerState();
}

class _AppLifecycleListenerState extends State<AppLifecycleListener>
    with WidgetsBindingObserver {
  var _lastAppLifecycleState = AppLifecycleState.resumed;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    setState(() {
      _lastAppLifecycleState = state;
    });

    // if (state == AppLifecycleState.resumed &&
    //     _lastAppLifecycleState == AppLifecycleState.paused) {
    //   widget.onReturnToApp?.call();
    // }
    // if (state != AppLifecycleState.inactive) _lastAppLifecycleState = state;
  }

  @override
  Widget build(BuildContext context) {
    if (_lastAppLifecycleState != AppLifecycleState.resumed) {
      return const ColoredBox(color: Colors.black);
    }
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
