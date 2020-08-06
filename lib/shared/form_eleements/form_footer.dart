import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  final Function action;
  final List<FooterStates> actions;
  const FormFooter({Key key, this.action, this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> getGeneratedList() {
      return actions
          .map((element) => FlatRoundedButton(
                lable: footerLagels[element],
                onPressed: () {
                  action(element);
                },
              ))
          .toList();
    }

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions == null ? [] : getGeneratedList(),
      ),
    );
  }
}

class FlatRoundedButton extends StatelessWidget {
  final String lable;
  final Function onPressed;

  const FlatRoundedButton({Key key, this.onPressed, this.lable})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        lable,
        style: TextStyle(
          color: AppColors.icons,
        ),
      ),
      onPressed: () {
        onPressed();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    );
  }
}
