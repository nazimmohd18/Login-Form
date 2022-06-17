import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/validations.dart';
import 'home_page.dart';
import 'package:login_form/utils/colors.dart';
import 'package:login_form/widgets/custom_text.dart';
import 'package:login_form/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  String email = "nazim@gmail.com";
  String password = "Nazim@123";

  saveUserCred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userEmail', email);
    prefs.setString('userPassword', password);
  }

  verifyUserData({String? userEmail, String? userPassword}) {
    if (email == userEmail && password == userPassword) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(
                user: userEmail!,
              )));
      saveUserCred();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
        ),
      );
    } else if (email == userEmail && password != userPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Password!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Email or Password!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          title: const Text("Login Form"),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(size.width * .05),
          child: Form(
            key: globalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  "Hey there!\nWelcome to the Login Page",
                  fontSize: 24,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  margin: EdgeInsets.symmetric(vertical: size.width * .25),
                ),
                CustomTextField(
                  title: 'Enter Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: EmailFieldValidator.validate,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  title: "Enter Password",
                  controller: passwordController,
                  obscureText: hidePassword,
                  textInputAction: TextInputAction.done,
                  validator: PasswordFieldValidator.validate,
                  suffixIcon: IconButton(
                    splashRadius: 1,
                    padding: const EdgeInsets.only(bottom: 10),
                    icon: Icon(
                      hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: greyColor,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: size.width * .15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (globalFormKey.currentState!.validate()) {
                      verifyUserData(userEmail: emailController.text, userPassword: passwordController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(size.width, 48)),
                  child: const CustomText(
                    "Login",
                    fontSize: 16,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
