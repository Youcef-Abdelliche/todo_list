import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../size_config.dart';

class TaskWidget extends StatefulWidget {
  final Color color;
  final int index;
  final String name;
  final Function function;

  const TaskWidget({Key key, this.color, this.index, this.name,this.function}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 0.2),
        width: SizeConfig.screenHeight,
        height: SizeConfig.screenWidth / 6,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 9),
              blurRadius: 20,
              spreadRadius: 1)
        ]),
        child: Row(
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
              width: SizeConfig.defaultSize * 2.6,
              height: SizeConfig.defaultSize * 2.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.color, width: 4)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.defaultSize * 1.9)),
                Text("3:30 PM",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.defaultSize * 1.7))
              ],
            ),
            Expanded(child: Container()),
            Container(
              width: 5,
              height: SizeConfig.defaultSize * 3,
              decoration: BoxDecoration(color: widget.color),
            )
          ],
        ),
      ),
      secondaryActions: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 0.5),
          child: IconSlideAction(
            icon: Icons.edit,
            caption: "Edit",
            color: Colors.green,
            onTap: () {
              print("object");
            },
          ),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 0.5),
          child: IconSlideAction(
            icon: Icons.delete,
            caption: "Edit",
            color: Colors.red[600],
            onTap: () {
              print("object");
              widget.function();
            },
          ),
        )
      ],
    );
  }
}
