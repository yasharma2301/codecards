import 'package:admob_flutter/admob_flutter.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdTile extends StatefulWidget {
  @override
  _AdTileState createState() => _AdTileState();
}

class _AdTileState extends State<AdTile> {
  AdmobReward _admobReward;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  @override
  void initState() {
    super.initState();
    _admobReward = createReward();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(hintKey) ?? 0);
    });
  }

  Future<int> _getIntFromSharedPref() async {
    final SharedPreferences prefs = await _prefs;
    final startupNumber = prefs.getInt(hintKey);
    return startupNumber;
  }

  Future<void> _incrementHint(int reward) async {
    int current = await _getIntFromSharedPref();
    // For test
     int newCurrent = current + (reward ~/ 10);
    // Real
    // int newCurrent = current + reward;
    setState(() {
      _counter = prefs.setInt("counter", newCurrent).then((bool success) {
        return newCurrent;
      });
    });
  }


  AdmobReward createReward() {
    return AdmobReward(
      // Test adUnitId : ca-app-pub-3940256099942544/5224354917
      // Production adUnitId : ca-app-pub-4588981695409423/1796109547
        adUnitId: "ca-app-pub-3940256099942544/5224354917",
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.loaded) {
            _admobReward.show();
          }
          if (event == AdmobAdEvent.closed) {
            _admobReward.dispose();
          }
          if (event == AdmobAdEvent.failedToLoad){
            print('failed to load the ad.');
          }
          if (event == AdmobAdEvent.rewarded) {
            _incrementHint(args["amount"]);
            print("type: ${args["type"]}");
            print("reward: ${args["amount"]}");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 220,
      width: width,
      color: Grey,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'WATCH AN AD TO INCREASE USE\nA HINT',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Hints\nYou Have:',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<int>(
                        future: _counter,
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const CircularProgressIndicator();
                            default:
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return Text('0',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700),
                                );
                              } else {
                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                );
                              }
                          }
                        }),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      try {
                        _admobReward.load();
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: Material(
                      elevation: 20,
                      child: Container(
                        height: 120,
                        width: 140,
                        decoration: BoxDecoration(
                          color: LightGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                right: -40,
                                top: -20,
                                child: Icon(
                                  Icons.lightbulb_outline,
                                  size: 130,
                                  color: Colors.white12,
                                )),
                            Center(
                              child: Text(
                                'Watch an\nAd',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
