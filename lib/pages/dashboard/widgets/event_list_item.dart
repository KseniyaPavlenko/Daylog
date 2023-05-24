import 'package:daylog/common/style/app_colors.dart';
import 'package:daylog/models/event.dart';
import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {
  const EventListItem({
    Key? key,
    required this.event,
    this.onTap,
    required this.isDraft,
  }) : super(key: key);
  final Event event;
  final VoidCallback? onTap;
  final bool isDraft;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDraft ? AppColors.grey : AppColors.brown,
        ),
        child: ListTile(
          //key: const Key('eventItem'),
          key: ValueKey(event.id),
          leading: const Icon(Icons.add_alert, size: 30),
          title: Text(event.title ?? ''),
          subtitle: Text(event.detail ?? ''),
          trailing: onTap == null ? null : const Icon(Icons.arrow_forward_ios),
          contentPadding: const EdgeInsets.all(10),
          enabled: true,
        ),
      ),
    );
  }
}
