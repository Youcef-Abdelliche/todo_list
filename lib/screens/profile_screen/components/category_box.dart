
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class CategoryBox extends StatelessWidget {
  final Color color;
  final String title;
  final int items;
  const CategoryBox({
    Key key,
    this.color,
    this.title,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: SizeConfig.defaultSize),
      width: SizeConfig.defaultSize * 18,
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.defaultSize * 3,
          horizontal: SizeConfig.defaultSize * 3),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize),
          Text(
            "$items Tasks",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}