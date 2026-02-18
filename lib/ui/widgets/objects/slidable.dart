import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/extension.dart';

class SlidableObject extends ConsumerWidget {
  final Function(BuildContext, WidgetRef) onEditCallback;
  final String title;
  final DateTime? date;
  final Widget icon;
  final Widget? subtitle;

  const SlidableObject({
    super.key,
    required this.onEditCallback,
    required this.title,
    required this.icon,
    this.date,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(isEditModeProvider);
    final appColors = Theme.of(context).extension<AppColors>()!;
    String formattedDate = '';

    if (date != null) {
      formattedDate = DateFormat('dd.MM.yyyy').format(date!);
    }
    return ListTile(
      leading: isEditMode
          ? IconButton(
              onPressed: () => Slidable.of(context)?.openEndActionPane(),
              icon: Icon(Icons.remove_circle, color: appColors.iconDelete),
            )
          : icon,
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          if (date != null) const SizedBox(width: 8),
          Text(
            formattedDate,
            style: TextStyle(fontSize: 12, color: appColors.textSecondary),
          ),
        ],
      ),
      subtitle: subtitle != null ? subtitle! : subtitle,
      onTap: isEditMode
          ? () => Slidable.of(context)?.openEndActionPane()
          : () async {
              onEditCallback(context, ref);
            },
    );
  }
}
