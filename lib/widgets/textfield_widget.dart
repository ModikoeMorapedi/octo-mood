import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;

  const TextFormFieldWidget({Key? key, this.textEditingController, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration:  InputDecoration(hintText: hintText),
    );
  }
}
