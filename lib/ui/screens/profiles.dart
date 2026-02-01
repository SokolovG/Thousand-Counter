import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/profile.dart';
import 'package:thousand_counter/ui/widgets/dialogs/profile_edit.dart';

class ProfilesScreen extends ConsumerWidget {
  const ProfilesScreen({super.key});

  void _showAddDialog(BuildContext context, WidgetRef ref) async {
    final name = await showProfileEditDialog(context);
    if (name != null && name.isNotEmpty) {
      await ref.read(profileServiceProvider).addProfile(name);
      ref.invalidate(profilesListProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(profilesListProvider);
    final isEditMode = ref.watch(isEditModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Players profiles"),
        actions: [
          if (!isEditMode)
            IconButton(
              onPressed: () => _showAddDialog(context, ref),
              icon: const Icon(Icons.add_circle_outline),
            ),
          IconButton(
            onPressed: () {
              ref.read(isEditModeProvider.notifier).update((state) => !state);
            },
            icon: Icon(isEditMode ? Icons.check : Icons.edit_outlined),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: profilesAsync.when(
        data: (profiles) => SlidableAutoCloseBehavior(
          child: ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, i) {
              final profile = profiles[i];
              return ProfileWidget(profile: profile);
            },
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
