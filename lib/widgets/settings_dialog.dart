import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhythm_flux/constant/app_texts.dart';

void settingsDialog(
  BuildContext context,
  Function(double) onChangedDouble,
  double volume,
  bool isMute,
  Function(bool) onChangedBool,
)  {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      double tempVolume = volume;
      bool tempMute = isMute;
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.purpleAccent, width: 2),
            ),

            title: const Center(
              child: Text(
                AppTexts.settings2,
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                  color: Colors.deepOrangeAccent,
                  fontSize: 14,
                  shadows: [Shadow(color: Colors.blueAccent, blurRadius: 10)],
                ),
              ),
            ),

            content: SizedBox(
              width: double.maxFinite,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        AppTexts.volume,
                        style: TextStyle(
                          fontFamily: 'PressStart2P',
                          color: Colors.purpleAccent,
                          fontSize: 10,
                        ),
                      ),
                      Slider(
                        value: tempVolume,
                        onChanged: tempMute
                            ? null
                            : (value) {
                                setState(() {
                                  tempVolume = value;
                                });
                                onChangedDouble(value);
                              },
                        min: 0,
                        max: 1,
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        AppTexts.music,
                        style: TextStyle(
                          fontFamily: 'PressStart2P',
                          color: Colors.purpleAccent,
                          fontSize: 10,
                        ),
                      ),
                      Switch(
                        value: tempMute,
                        onChanged: (value) {
                          setState(() {
                            tempMute = value;
                          });
                          onChangedBool(value);
                        },
                      ),
                    ],
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text(
                      "EXIT GAME",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PressStart2P',
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  AppTexts.close,
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
    },
  );
}
