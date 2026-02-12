import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/ui/widgets/dialogs/round.dart';

void roundsHistoryDialog(
  BuildContext context,
  WidgetRef ref,
  Game currentGame,
  Color roundColor,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final screenSize = MediaQuery.of(context).size;
      return Dialog(
        child: SizedBox(
          height: screenSize.height * 0.6,
          width: screenSize.width,
          child: Column(
            children: [
              Text("Rounds history"),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        roundialog(
                          context,
                          ref,
                          currentGame.rounds[index],
                          currentGame,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: roundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("${index + 1}")),
                      ),
                    );
                  },
                  itemCount: currentGame.rounds.length,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
