import 'package:daylog/common/utils/context_utils.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/error_cubit/error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonScaffold extends StatefulWidget {
  const CommonScaffold({
    Key? key,
    required this.body,
    this.isLoading = false,
    this.bottomBar,
    this.floatButton,
  }) : super(key: key);

  final Widget body;
  final bool isLoading;
  final Widget? bottomBar;
  final Widget? floatButton;

  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorCubit, ErrorState>(
      listener: (context, state) {
        if (state.hasError) {
          context.showError(state.message);
          context.read<ErrorCubit>().clearError();
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
