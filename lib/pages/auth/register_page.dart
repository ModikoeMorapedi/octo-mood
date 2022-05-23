import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/services/authentication_service.dart';
import 'package:octo_mood/services/database_service.dart';
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
        resizeToAvoidBottomInset:
            false, //avoid overflow when the user enter values on the TextFormField
        body: Container(
            color: ColorsUtil.whiteColor,
            child: Column(
              children: [
                //Header
                headerWidget(context),
                Container(
                  padding: const EdgeInsets.only(top: 50, left: 35, right: 35),
                  width: MediaQuery.of(context).size.width,
                  color: ColorsUtil.whiteColor,
                  child: Column(
                    children: [
                      //Body
                      bodyWidget(context),
                      //Footer
                      footerWidget(context),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      height: 250,
      color: ColorsUtil.greenColor,
      padding: const EdgeInsets.only(top: 90, bottom: 30),
      child: Column(
        children: [
          const Text(
            StringsUtil.createAccount + "👨‍💻",
            style: TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
          ),
          Container(
            color: ColorsUtil.whiteColor,
            width: 275,
            height: 4,
          ),
        ],
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Column(
      children: [
        TextFormFieldWidget(
          hintText: StringsUtil.pleaseEnterYourNickName,
          textEditingController: _nickNameController,
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormFieldWidget(
          hintText: StringsUtil.pleaseEnterYourEmail,
          textEditingController: _emailController,
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormFieldWidget(
          hintText: StringsUtil.pleaseEnterYourPassword,
          textEditingController: _passwordController,
        ),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }

  Widget footerWidget(BuildContext context) {
    return SolidButtonWidget(
      onPressed: () async {
        final response = await AuthenticationService().registration(
            email: _emailController.text, password: _passwordController.text);
        if (response!.contains(StringsUtil.success)) {
          DatabaseService().createNewUserInFirestore(_nickNameController.text);
          Navigator.pushNamed(context, StringsUtil.loginPage);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response),
          ),
        );
      },
      text: StringsUtil.createAccount,
      width: MediaQuery.of(context).size.width,
    );
  }
}
