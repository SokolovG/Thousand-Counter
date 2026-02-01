import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/player_dialogs.dart';

class PlayerWidget extends ConsumerWidget {
  final Profile profile;

  const PlayerWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) async {
              await ref.read(profileServiceProvider).deleteProfile(profile.id);
              ref.invalidate(profilesListProvider);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),
      child: ListTile(
        title: Text(profile.name),
        leading: const Icon(Icons.person),
        onTap: () async {
          final newName = await showPlayerEditDialog(
            context,
            initialName: profile.name,
          );
          if (newName != null && newName != profile.name) {
            await ref
                .read(profileServiceProvider)
                .updateProfile(profile.id, newName);
            Future.microtask(() => ref.invalidate(profilesListProvider));
          }
        },
      ),
    );
  }
}
