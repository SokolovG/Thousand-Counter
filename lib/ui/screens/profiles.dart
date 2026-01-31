import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';

class PlayersScreen extends ConsumerWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(profilesListProvider);
    final profileService = ref.read(profileServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Players profiles"),
        actions: [
          IconButton(
            onPressed: () async {
              final controller = TextEditingController();
              final name = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: Text("Add new player profile"),
                        content: TextField(
                          controller: controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Zа-яА-Я\s]'),
                            ),
                          ],
                          onChanged: (enteredText) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: "Enter player name",
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: controller.text.trim().isNotEmpty
                                ? () {
                                    final text = controller.text;
                                    Navigator.pop(context, text.trim());
                                  }
                                : null,
                            child: Text("Save"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
              if (name != null && name.isNotEmpty) {
                await profileService.addProfile(name);
                ref.invalidate(profilesListProvider);
              }
              await Future.delayed(Duration.zero);
              controller.dispose();
            },
            icon: Icon(Icons.add_circle_outline_sharp),
          ),

          IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: profilesAsync.when(
        data: (players) => ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, i) => PlayerWidget(name: players[i].name),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
