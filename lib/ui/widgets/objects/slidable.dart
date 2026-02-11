import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/extension.dart';

class SlidableObject extends ConsumerWidget {
  final Function(BuildContext, WidgetRef) onEditCallback;
  final String title;
  final Widget icon;
  final String? subtitle;

  const SlidableObject({
    super.key,
    required this.onEditCallback,
    required this.title,
    required this.icon,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(isEditModeProvider);
    final appColors = Theme.of(context).extension<AppColors>()!;

    return ListTile(
      leading: isEditMode
          ? IconButton(
              onPressed: () => Slidable.of(context)?.openEndActionPane(),
              icon: Icon(Icons.remove_circle, color: appColors.iconDelete),
            )
          : icon,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      onTap: isEditMode
          ? () => Slidable.of(context)?.openEndActionPane()
          : () async {
              onEditCallback(context, ref);
            },
    );
  }
}
