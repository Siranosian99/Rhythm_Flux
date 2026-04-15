import 'package:flutter/material.dart';

Future<void> settingsDialog(BuildContext context,  Function(double) onChangedDouble,double volume,bool isMute,Function(bool) onChangedBool) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      double tempVolume = volume;
      bool tempMute=isMute;
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
                        onChanged: tempMute?null:(value){
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
                        "MUSIC",
                        style: TextStyle(
                          fontFamily: 'PressStart2P',
                          color: Colors.purpleAccent,
                          fontSize: 10,
                        ),
                      ),
                      Switch(
                        value: tempMute,
                        onChanged: (value){
                          setState((){
                            tempMute=value;
                          });
                       onChangedBool(value);
                        },
                      ),
                    ],
                  ),

                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.redAccent,
                  //   ),
                  //   onPressed: null, // UI only
                  //   child: const Text(
                  //     "EXIT GAME",
                  //     style: TextStyle(
                  //       fontFamily: 'PressStart2P',
                  //       fontSize: 10,
                  //     ),
                  //   ),
                  // ),
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