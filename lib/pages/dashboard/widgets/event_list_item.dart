import 'package:daylog/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {
  const EventListItem({
    Key? key,
    required this.event,
    this.onTap,
  }) : super(key: key);
  final Event event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[800],
        ),
        child: ListTile(
          leading: const Icon(
            Icons.add_alert,
            size: 30,
          ),
          title: Text(event.title ?? ''),
          subtitle: const Text('test subtitle'),
          trailing: onTap == null ? null : const Icon(Icons.arrow_forward_ios),
          contentPadding: const EdgeInsets.all(10),
          enabled: true,
          iconColor: Colors.white,
          textColor: Colors.white,
          tileColor: Colors.grey[600],
          //// shape:
          //    RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }
}
