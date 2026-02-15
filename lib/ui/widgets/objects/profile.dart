import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/extension.dart';
import 'package:thousand_counter/ui/widgets/dialogs/profile_edit.dart';
import 'package:thousand_counter/ui/widgets/objects/slidable.dart';

class ProfileWidget extends ConsumerWidget {
  final Profile profile;

  const ProfileWidget({super.key, required this.profile});

  void _onDelete(WidgetRef ref) async {
    await ref.read(profileServiceProvider).deleteProfile(profile.id);
    ref.invalidate(profilesListProvider);
  }

  void _onEdit(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final newName = await showProfileEditDialog(
      context,
      initialName: profile.name,
    );
    if (newName != null && newName != profile.name) {
      final updatedProfile = profile.copyWith(name: newName);
      await ref
          .read(profileServiceProvider)
          .updateProfile(updatedProfile, l10n);
      ref.invalidate(profilesListProvider);
      Future.microtask(() => ref.invalidate(profilesListProvider));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(isEditModeProvider);
    final appColors = Theme.of(context).extension<AppColors>()!;
    final l10n = AppLocalizations.of(context)!;

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
            backgroundColor: appColors.iconDelete,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          ),
        ],
      ),

      child: Builder(
        builder: (innerContext) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: appColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: appColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SlidableObject(
                onEditCallback: (context, ref) {
                  _onEdit(context, ref, l10n);
                },
                title: profile.name,
                icon: Icon(Icons.person),
              ),
            ),
          );
        },
      ),
    );
  }
}
