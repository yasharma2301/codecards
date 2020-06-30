import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateUs extends StatefulWidget {
  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double _rating;
    String comments;

    return Container(
      width: size.width,
      height: size.height / 2,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          title: Text("Rate Us"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: RatingBar(
                  minRating: 1,
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  // itemBuilder: (context, _) => Icon(
                  //   Icons.star,
                  //   color: Theme.of(context).primaryColor,
                  // ),
                  ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                    ),
                    half: Icon(
                      Icons.star_half,
                      color: Theme.of(context).primaryColor,
                    ),
                    empty: Icon(
                      Icons.star_border,
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.15),
                    ),
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                    print(_rating);
                  },
                ),
              ),
              Container(
                width: size.width - 50,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Grey, borderRadius: BorderRadius.circular(6)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: LightGrey.withOpacity(0.7),
                  ),
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColorLight,
                    maxLines: 3,
                    style: TextStyle(fontSize: 18, color: White),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Comments...",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.7))),
                    onChanged: (text) {
                      setState(() {
                        comments = text;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    _rating != null ? Navigator.pop(context) : print(_rating);
                    // : Scaffold.of(context).showSnackBar(SnackBar(
                    //     content: Text("Please rate before Posting!"),
                    //     duration: Duration(seconds: 3)));
                  },
                  child: Ink(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorLight
                          ],
                          stops: [
                            0.3,
                            0.95
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.topRight,
                          tileMode: TileMode.repeated),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Text(
                      "Post Review",
                      style: TextStyle(
                        color: White,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
