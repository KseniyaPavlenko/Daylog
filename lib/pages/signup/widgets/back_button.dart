import 'package:daylog/common/route/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButton extends StatelessWidget {
   BackButton({
    Key? key,
     this.text,
     this.func,
  }) : super(key: key);
   String? text;
   void Function()? func;


  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
      ),
      child: Text(
        text = "Already have an account? Login",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed:()=> GoRouter.of(context).go(AppRouter.login),
      
      //GoRouter.of(context).go(AppRouter.login),
    );
  }
}
