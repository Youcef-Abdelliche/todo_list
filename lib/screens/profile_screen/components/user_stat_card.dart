import 'package:flutter/material.dart';

import '../../../size_config.dart';

class UserStatCard extends StatelessWidget {
  const UserStatCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 9),
                  blurRadius: 20,
                  spreadRadius: 1)
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.defaultSize * 3,
              horizontal: SizeConfig.defaultSize),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 2),
                child: Row(children: [
                  CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/imageee.jpg")),
                  SizedBox(width: SizeConfig.defaultSize * 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Youcef Abdelliche",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      Text("hy_abdelliche@esi.dz",
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  )
                ]),
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("120",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    Text("Created Tasks",
                        style: TextStyle(fontSize: 16, color: Colors.grey))
                  ],
                ),
                SizedBox(width: SizeConfig.defaultSize * 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("80",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    Text("Completed Tasks",
                        style: TextStyle(fontSize: 16, color: Colors.grey))
                  ],
                )
              ]),
            ],
          ),
        ));
  }
}