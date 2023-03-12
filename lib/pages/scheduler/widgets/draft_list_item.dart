import 'package:daylog/models/draft.dart';
import 'package:flutter/material.dart';

class DraftListItem extends StatelessWidget {
  const DraftListItem({
    Key? key,
    required this.draft,
    this.onTap,
  }) : super(key: key);

  final Draft draft;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.brown[900], // TODO(Kseniya): AppColors.
          //color: Colors.grey[800],   // TODO(Kseniya): удали
        ),
        child: ListTile(
          leading: const Icon(Icons.add_alert, size: 30),
          title: Text(draft.title ?? ''),
          subtitle: const Text('test subtitle'),
          // TODO(Kseniya): вынеси в private getter выше build
          trailing: onTap == null ? null : const Icon(Icons.arrow_forward_ios),
          contentPadding: const EdgeInsets.all(10),
          enabled: true,
          // TODO(Kseniya): удали
          // iconColor: Colors.white,
          //textColor: Colors.white,
          //tileColor: Colors.grey[600],
          //// shape:
          //    RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }
}
