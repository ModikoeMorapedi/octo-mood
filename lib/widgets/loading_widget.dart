import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/images_util.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsUtil.whiteColor,
      alignment: Alignment.center,
      child: Image.asset(
        ImagesUtil.octoImage,
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      ),
    );
  }
}
