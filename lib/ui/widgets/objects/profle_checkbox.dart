import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/profile.dart';

class ProfilesCheckBoxWidget extends ConsumerWidget {
  final List<Profile> profiles;
  final Set<String> selectedIds;
  final Function onChanged;

  const ProfilesCheckBoxWidget({
    super.key,
    required this.profiles,
    required this.selectedIds,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        return CheckboxListTile(
          title: Text(profile.name),
          value: selectedIds.contains(profile.id),
          onChanged: (checked) {
            onChanged(profile.id);
          },
        );
      },
    );
  }
}
