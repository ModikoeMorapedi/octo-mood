import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/utils/colors_util.dart';

class SolidButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color? color;
  final double? width;
  final double? height;
  final Color? textColor;

  const SolidButtonWidget(
      {Key? key,
      this.onPressed,
      this.text,
      this.color,
      this.width,
      this.textColor,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: height ?? 50,
          minWidth: width ?? 250,
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color ?? ColorsUtil.greyColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(35.0)),
            ),
            onPressed: onPressed,
            child: Text(
              text!,
              style: TextStyle(
                  color: textColor ?? ColorsUtil.whiteColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            )));
  }
}
