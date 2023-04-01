import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.onTap,
    this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        
        controller: controller,
        onTap: onTap,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          fillColor: Colors.black12,
          filled: true,
          icon: icon,
          suffix: GestureDetector(
            onTap: () => controller.clear(),
            child: const Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}
