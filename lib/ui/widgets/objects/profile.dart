import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/dialogs/profile_edit.dart';

class ProfileWidget extends ConsumerWidget {
  final Profile profile;

  const ProfileWidget({super.key, required this.profile});

  void _onDelete(WidgetRef ref) async {
    await ref.read(profileServiceProvider).deleteProfile(profile.id);
    ref.invalidate(profilesListProvider);
  }

  void _onEdit(BuildContext context, WidgetRef ref) async {
    final newName = await showProfileEditDialog(
      context,
      initialName: profile.name,
    );
    if (newName != null && newName != profile.name) {
      await ref.read(profileServiceProvider).updateProfile(profile.id, newName);
      Future.microtask(() => ref.invalidate(profilesListProvider));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(isEditModeProvider);

    return Slidable(
      key: ValueKey(isEditMode),
      groupTag: "profiles_list",
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              _onDelete(ref);
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),

      child: Builder(
        builder: (innerContext) {
          return ListTile(
            leading: isEditMode
                ? IconButton(
                    onPressed: () =>
                        Slidable.of(innerContext)?.openEndActionPane(),
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                  )
                : const Icon(Icons.person),
            title: Text(profile.name),
            onTap: isEditMode
                ? () => Slidable.of(innerContext)?.openEndActionPane()
                : () async {
                    _onEdit(context, ref);
                  },
          );
        },
      ),
    );
  }
}
