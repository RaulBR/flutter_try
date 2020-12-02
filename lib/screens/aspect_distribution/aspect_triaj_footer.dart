import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

// duplicate
class AspectTriajFooter extends StatelessWidget {
  final List<String> actions;
  final Function getAction;
  const AspectTriajFooter({Key key, this.actions, this.getAction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            onPressed: () {
              getAction(actions[0]);
            },
            child: Text(
              actions[0],
              style: actions[0] == Labels.rejected
                  ? TextStyle(color: AppColors.fieldInFocus)
                  : null,
            ),
          ),
          FlatButton(
            onPressed: () {
              getAction(Labels.ditail);
            },
            child: Text(Labels.ditail),
          ),
          FlatButton(
            onPressed: () {
              getAction(actions[1]);
            },
            child: Icon(
              Icons.check,
              color: AppColors.accent,
            ),
          )
        ],
      ),
    );
  }
}
