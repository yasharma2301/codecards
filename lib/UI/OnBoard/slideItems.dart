import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/OnBoard/slide_details.dart';
import 'package:flutter/material.dart';
class Items extends StatelessWidget {
  final int index;
  const Items(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(SlideList[index].image),
                  fit: BoxFit.cover
              )
          ),
        ),SizedBox(height: 20,),
        Text(
          SlideList[index].title,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: White,
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            SlideList[index].description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: White,
            ),
          ),
        ),
      ],
    );
  }
}

