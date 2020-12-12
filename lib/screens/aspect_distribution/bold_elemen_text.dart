import 'package:flutter/material.dart';

class BoldElementText extends StatelessWidget {
  final String boldText;
  final String text;

  const BoldElementText({Key key, this.boldText, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: text == null ? 1 : 3,
      text: TextSpan(
        text: boldText,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: text,

            style: TextStyle(
              // color: Colors.green,
              fontWeight: FontWeight.normal,
              decorationStyle: TextDecorationStyle.wavy,
            ),
            //  recognizer: _longPressRecognizer,
          ),
        ],
      ),
    );
  }
}
