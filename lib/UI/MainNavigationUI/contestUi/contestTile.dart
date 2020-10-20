import 'package:codecards/UI/MainNavigationUI/contestUi/contestDetail.dart';
import 'package:flutter/material.dart';

class ContestTile extends StatelessWidget {
  final width, darkTheme, border, contestObject;

  const ContestTile(
      {Key key, this.width, this.darkTheme, this.border, this.contestObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = contestObject.start.split('T')[0];
    String time = contestObject.start.split('T')[1].replaceAll('Z', '');
    String iconURL = "https://clist.by${contestObject.icon}";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ContestDetail(
                      contestsAPIModel: contestObject,
                    )),
          );
        },
        child: Stack(
          children: [
            Container(
              height: 120,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorLight
                    ],
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                    tileMode: TileMode.repeated),
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(5.0, 10))
                ],
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8, left: 10, right: 10),
                  child: Text(
                    contestObject.name,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              height: 90,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 5))
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    bottom: -30,
                    child: Icon(
                      Icons.texture,
                      size: 150,
                      color: Colors.grey[200].withOpacity(0.3),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          height: 80,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(10)),
                            image: DecorationImage(
                              // image: AssetImage('assets/codechef.jpg'),
                              image: NetworkImage(iconURL),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          color: Colors.grey,
                          height: 60,
                          width: 0.5,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      contestObject.event,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Start: $date\n$time',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
