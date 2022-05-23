import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/services/authentication_service.dart';
import 'package:octo_mood/services/database_service.dart';
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
        resizeToAvoidBottomInset: false,
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
                  onPressed: () async {
                    final response = await AuthenticationService().login(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (response!.contains(StringsUtil.success)) {
                      Navigator.pushNamed(context, StringsUtil.moodsPage);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response),
                        ),
                      );
                    }
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
                  height: 10,
                ),
                SolidButtonWidget(
                  onPressed: () async {
                    final response =
                        await AuthenticationService().signInwithGoogle();
                    if (response!.isNotEmpty) {
                      DatabaseService().createNewUserInFirestore(response);
                      Navigator.pushNamed(context, StringsUtil.moodsPage);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response),
                        ),
                      );
                    }
                  },
                  text: StringsUtil.googleSignIn,
                ),
              ],
            )));
  }
}
