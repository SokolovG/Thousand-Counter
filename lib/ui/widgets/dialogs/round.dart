import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/round.dart';

void roundialog(
  BuildContext context,
  WidgetRef ref,
  Round round,
  Game currentGame,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final screenSize = MediaQuery.of(context).size;
      return Dialog(
        child: SizedBox(
          height: screenSize.height * 0.5,
          width: screenSize.width * 0.9,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Round details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView(
                  children: currentGame.players.map((p) {
                    final score = round.playerScores[p.profile.id] ?? 0;
                    return ListTile(
                      title: Text(p.profile.name),
                      trailing: Text(
                        score > 0 ? "+$score" : "$score",
                        style: TextStyle(
                          color: score > 0
                              ? Colors.green
                              : (score < 0 ? Colors.red : Colors.grey),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
