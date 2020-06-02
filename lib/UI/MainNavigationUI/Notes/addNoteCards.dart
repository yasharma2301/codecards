import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        height: 200,
        width: 170,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: () {},
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 10,
              color: LightGrey.withOpacity(0.7),
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 100,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 100,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 100,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 100,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 100,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 100,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 100,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 70,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 70,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 60,color: Grey.withOpacity(0.6),height: 2,),
                        SizedBox(height: 5,),
                        Container(width: 30,color: Grey.withOpacity(0.6),height: 2,),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Grey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.pencilAlt,
                          size: 16,
                          color: LightGrey.withOpacity(0.9),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}