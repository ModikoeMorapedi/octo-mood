import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/services/authentication_service.dart';
import 'package:octo_mood/services/database_service.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/strings_util.dart';
import 'package:octo_mood/widgets/button_widget.dart';
import 'package:octo_mood/widgets/textfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';

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
        ),
      ),
    );
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
          Text(
            StringsUtil.signIn + "😎",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: ColorsUtil.whiteColor,
            width: 180,
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
          hintText: StringsUtil.pleaseEnterYourEmail,
          textEditingController: _emailController,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormFieldWidget(
          obscureText: true,
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
    return Column(
      children: [
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
          width: MediaQuery.of(context).size.width,
        ),
        const SizedBox(
          height: 10,
        ),
        SolidButtonWidget(
          onPressed: () {
            Navigator.pushNamed(context, StringsUtil.registerPage);
          },
          text: StringsUtil.createAccount,
          width: MediaQuery.of(context).size.width,
        ),
        const SizedBox(
          height: 10,
        ),
        SolidButtonWidget(
          onPressed: () async {
            final response = await AuthenticationService().signInwithGoogle();
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
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}
