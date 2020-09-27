import 'package:flutter/material.dart';

class TagPillList extends StatefulWidget {
  final String data;
  final Color color;

  const TagPillList({Key key, this.data, this.color}) : super(key: key);

  @override
  _TagPillListState createState() => _TagPillListState();
}

class _TagPillListState extends State<TagPillList> {
  @override
  Widget build(BuildContext context) {
    if (widget.data != '') {
      var tagArray = widget.data.split(',').toList();
      return Container(
        height: 30,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        tagArray[index],
                        style: TextStyle(
                            color: widget.color,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: tagArray.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    } else {
      return Container();
    }
  }
}
