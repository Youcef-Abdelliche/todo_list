import 'package:flutter/material.dart';
import 'package:todo_list/models/task_category.dart';
import 'package:todo_list/size_config.dart';

class ProgressCircularIndicator extends StatelessWidget {
  final TaskCategory taskCategory;
  const ProgressCircularIndicator({Key key, this.taskCategory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double size = 8.0;
    final double percentToRadian = 0.062831853071796;
    int perst = 0;
    return Center(
        child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 3),
            builder: (context, value, child) {
              if ((value * 100).ceil() <=
                  taskCategory.itemsFinished * 100 / taskCategory.items)
                perst = (value * 100).ceil();
              return Container(
                height: SizeConfig.defaultSize * size,
                width: SizeConfig.defaultSize * size,
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: -3.14 / 2,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return SweepGradient(
                              startAngle: 0,
                              endAngle: (taskCategory.itemsFinished == 0)
                                  ? percentToRadian
                                  : taskCategory.itemsFinished *
                                      100 *
                                      percentToRadian /
                                      taskCategory.items,
                              stops: [value, value],
                              center: Alignment.center,
                              colors: [
                                Color(taskCategory.color),
                                Colors.grey.withAlpha(55)
                              ]).createShader(rect);
                        },
                        child: Container(
                          height: SizeConfig.defaultSize * size,
                          width: SizeConfig.defaultSize * size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: SizeConfig.defaultSize * size -
                            SizeConfig.defaultSize,
                        width: SizeConfig.defaultSize * size -
                            SizeConfig.defaultSize,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                          "$perst %",
                          style: TextStyle(fontSize: SizeConfig.defaultSize),
                        )),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
