import 'package:daylog/common/utils/context_utils.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/error_cubit/error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    Key? key,
    required this.body,
    this.isLoading = false,
    this.bottomBar,
    this.floatingActionButton,
    this.appBar,
    this.backgroundColor,
  }) : super(key: key);

  final Widget body;
  final bool isLoading;
  final Widget? bottomBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

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
        appBar: appBar,
        backgroundColor: backgroundColor,
        floatingActionButton: floatingActionButton,
        body: Stack(
          children: [
            body,
            if (isLoading)
              Container(
                alignment: Alignment.center,
                color: Colors.grey[400],
                child: CircularProgressIndicator(
                  color: Colors.grey[850],
                ),
              ),
          ],
        ),
        bottomNavigationBar: bottomBar,
      ),
    );
  }
}
