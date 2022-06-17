import 'package:flutter/material.dart';
import 'package:login_form/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("userEmail");
  var password = prefs.getString("userPassword");
  runApp(MyApp(
    email: email ?? "",
    password: password ?? "",
  ));
}

class MyApp extends StatelessWidget {
  final String? email;
  final String? password;
  const MyApp({Key? key, this.email, this.password}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Form',
      debugShowCheckedModeBanner: false,
      home: (email!.isEmpty && password!.isEmpty) ? const LoginPage() : HomePage(user: email!),
    );
  }
}
