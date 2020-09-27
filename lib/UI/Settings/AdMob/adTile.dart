import 'package:codecards/Services/AdProvider/adProvider.dart';
import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codecards/Shared/Colors.dart';

SharedPreferences preferences;

class AdTile extends StatefulWidget {
  final HintCounter hintCounter;

  const AdTile({Key key, this.hintCounter}) : super(key: key);

  @override
  _AdTileState createState() => _AdTileState();
}

class _AdTileState extends State<AdTile> {
  AdmobReward _admobReward;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _admobReward = createReward(widget.hintCounter);
  }

  AdmobReward createReward(HintCounter hintCounter) {
    return AdmobReward(
      // Test adUnitId : ca-app-pub-3940256099942544/5224354917
      // Production adUnitId : ca-app-pub-4588981695409423/1796109547
      adUnitId: "ca-app-pub-3940256099942544/5224354917",
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.loaded) {
          _admobReward.show();
        }
        if (event == AdmobAdEvent.completed) {
          setState(() {
            loading = false;
          });
        }
        if (event == AdmobAdEvent.closed) {
          setState(() {
            loading = false;
          });
          _admobReward.dispose();
        }
        if (event == AdmobAdEvent.failedToLoad) {
          setState(() {
            loading = false;
          });
          print('failed to load the ad.');
        }
        if (event == AdmobAdEvent.rewarded) {
          setState(() {
            loading = false;
          });
          hintCounter.increaseHints();
          print("type: ${args["type"]}");
          print("reward: ${args["amount"]}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    HintCounter hintProvider = Provider.of<HintCounter>(context);
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 220,
      width: width,
      color: darkTheme.getMode() == true ? Grey : White,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'WATCH AN AD TO USE A\nHINT',
              style: TextStyle(
                  color: darkTheme.getMode() == true ? White : Grey,
                  fontSize: 18),
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
                      style: TextStyle(
                          color: darkTheme.getMode() == true ? White : Grey,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      hintProvider.getHint().toString(),
                      style: TextStyle(
                          color: darkTheme.getMode() == true ? White : Grey,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        loading = true;
                      },
                    );
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
                            ),
                          ),
                          Center(
                            child: loading
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : Text(
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
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
