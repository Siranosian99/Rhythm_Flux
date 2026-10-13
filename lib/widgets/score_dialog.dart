import 'package:flutter/material.dart';

import '../constant/app_texts.dart';

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
          child: ListView.builder(
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