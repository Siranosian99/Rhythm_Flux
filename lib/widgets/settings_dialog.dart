import 'package:flutter/material.dart';

Future<void> settingsDialog(BuildContext context,  Function(double) onChanged,double volume) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      double tempVolume = volume;
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
                'SETTINGS',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Column(
                    children: [
                      const Text(
                        "VOLUME",
                        style: TextStyle(
                          fontFamily: 'PressStart2P',
                          color: Colors.purpleAccent,
                          fontSize: 10,
                        ),
                      ),
                      Slider(
                        value: tempVolume,
                        onChanged: (value){
                          setState(() {
                            tempVolume = value;
                          });

                          onChanged(value);
                        },
                        min: 0,
                        max: 1-0,
                      ),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "MUSIC",
                        style: TextStyle(
                          fontFamily: 'PressStart2P',
                          color: Colors.purpleAccent,
                          fontSize: 10,
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: null,
                      ),
                    ],
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: null, // UI only
                    child: const Text(
                      "EXIT GAME",
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 10,
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
                  'CLOSE',
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