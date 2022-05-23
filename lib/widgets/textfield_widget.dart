import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/utils/colors_util.dart';

//TextFormFieldWidget
class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final Color? color;
  final double? width;
  final bool? obscureText;
  final Color? hintColor;

  const TextFormFieldWidget(
      {Key? key,
      this.textEditingController,
      this.hintText,
      this.color,
      this.width,
      this.obscureText,
      this.hintColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: textEditingController,
      style: TextStyle(
        fontSize: 15,
        color: color ?? ColorsUtil.blackColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor ?? ColorsUtil.blackColor),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: color ?? ColorsUtil.blackColor, width: width ?? 1)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: color ?? ColorsUtil.blackColor, width: width ?? 1)),
      ),
    );
  }
}
