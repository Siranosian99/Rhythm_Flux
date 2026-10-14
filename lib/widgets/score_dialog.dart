import 'package:flutter/material.dart';

import '../core/constant/app_texts.dart';

void scoreDialog(BuildContext context, List<int> scores)  {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.purpleAccent, width: 2),
        ),

        title: Center(
          child: Text(
            AppTexts.scores2,
            style: TextStyle(
              fontFamily: 'PressStart2P',
              color: Colors.deepOrangeAccent,
              fontSize: 14,
              shadows: [
                Shadow(color: Colors.blueAccent, blurRadius: 10),
              ],
            ),
          ),
        ),

        content: SizedBox(
          width: double.maxFinite,
          height: 200,
          child: scores.isEmpty?Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF151126),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.purpleAccent.withValues(alpha: 0.65),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withValues(alpha: 0.12),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    size: 42,
                    color: Colors.lightBlueAccent.withValues(alpha: 0.9),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                   AppTexts.noScores,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      color: Colors.purpleAccent,
                      fontSize: 10,
                      letterSpacing: 1.2,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                  AppTexts.playToGet,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 7,
                      height: 2.2,
                    ),
                  ),
                ],
              ),
            ),
          ):ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#${index + 1}',
                          style: TextStyle(
                            fontFamily: 'PressStart2P',
                            color: Colors.purpleAccent,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          scores[index].toString(),
                          style: TextStyle(
                            fontFamily: 'PressStart2P',
                            color: Colors.blueAccent,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppTexts.close2,
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.purpleAccent,
                fontSize: 10,
              ),
            ),
          ),
        ],
      );
    },
  );
}