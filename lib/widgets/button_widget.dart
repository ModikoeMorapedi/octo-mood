import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SolidButtonWidget extends StatelessWidget {

  final VoidCallback? onPressed;
  final String? text;

  const SolidButtonWidget({Key? key,this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text!));
  }
}