import 'package:flutter/material.dart';

class CommonLoadingIndicator extends StatelessWidget {
  const CommonLoadingIndicator({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isLoading)
          Container(
            alignment: Alignment.center,
            color: Colors.grey[400],
            child: CircularProgressIndicator(
              color: Colors.grey[850],
            ),
          ),
        child,
      ],
    );
  }
}
