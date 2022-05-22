import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/services/authentication_service.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/strings_util.dart';
import 'package:octo_mood/widgets/button_widget.dart';

import '../../widgets/textfield_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(35),
            color: ColorsUtil.greenColor,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: const Text(
                    StringsUtil.createAccount,
                    style: TextStyle(
                        color: ColorsUtil.whiteColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormFieldWidget(
                  hintText: StringsUtil.pleaseEnterYourNickName,
                  textEditingController: _nickNameController,
                ),
                TextFormFieldWidget(
                  hintText: StringsUtil.pleaseEnterYourEmail,
                  textEditingController: _emailController,
                ),
                TextFormFieldWidget(
                  hintText: StringsUtil.pleaseEnterYourPassword,
                  textEditingController: _passwordController,
                ),
                const SizedBox(
                  height: 80,
                ),
                SolidButtonWidget(
                  onPressed: () async {
                    final response = await AuthenticationService().registration(
                        email: _emailController.text,
                        password: _passwordController.text,
                        nickName: _nickNameController.text);
                    if (response!.contains("success")) {
                      Navigator.pushNamed(context, StringsUtil.loginPage);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response),
                      ),
                    );
                  },
                  text: StringsUtil.createAccount,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )));
  }
}
