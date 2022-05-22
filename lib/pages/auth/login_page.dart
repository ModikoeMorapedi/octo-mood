import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/utils/strings_util.dart';
import 'package:octo_mood/widgets/button_widget.dart';
import 'package:octo_mood/widgets/textfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(35),
            color: Colors.green,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: const Text(
                    StringsUtil.signIn,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
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
                  onPressed: () {
                    Navigator.pushNamed(context, StringsUtil.homePage);
                  },
                  text: StringsUtil.signIn,
                ),
                SolidButtonWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, StringsUtil.registerPage);
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
