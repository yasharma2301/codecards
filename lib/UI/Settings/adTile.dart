import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

class AdTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 220,
      width: width,
      color: Grey,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'INCREASE THE DAILY HINT LIMIT',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Today\'s\nHints Remaining',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '2',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {},
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
