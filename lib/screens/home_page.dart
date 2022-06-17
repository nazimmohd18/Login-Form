import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import '../api/api.dart';
import 'package:flutter/material.dart';
import 'package:login_form/widgets/custom_text.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  final String user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Future? fetchMedicine;

  @override
  void initState() {
    super.initState();
    fetchMedicine = Api.getMedicine();
  }

  removeCred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userEmail");
    prefs.remove("userPassword");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: const Text("Home Page"),
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        actions: [
          TextButton(
              onPressed: () {
                removeCred();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logout Successful!'),
                  ),
                );
              },
              child: const CustomText(
                "Logout",
                fontSize: 16,
                color: secondaryColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                greeting(),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                margin: EdgeInsets.only(top: size.width * .25, bottom: size.width * .05),
              ),
            ),
            Center(
              child: CustomText(
                widget.user,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(
              height: size.width * .2,
            ),
            const CustomText(
              'Your Medicine Details:',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            const Divider(
              color: primaryColor,
              thickness: 1,
              height: 30,
            ),
            SizedBox(
              height: size.width * .1,
            ),
            FutureBuilder(
              future: fetchMedicine,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CustomText(
                      'Loading....',
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    );
                  default:
                    if (snapshot.hasError) {
                      return CustomText(
                        " Error: ${snapshot.error}",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      );
                    } else {
                      return Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              CustomText(
                                'Name:',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                                margin: EdgeInsets.only(bottom: 6),
                              ),
                              CustomText(
                                'Dose:',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                                margin: EdgeInsets.only(bottom: 6),
                              ),
                              CustomText(
                                'Strength:',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                '${snapshot.data["name"]}',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                                margin: const EdgeInsets.only(bottom: 6),
                              ),
                              CustomText(
                                '${snapshot.data["dose"]}',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                                margin: const EdgeInsets.only(bottom: 6),
                              ),
                              CustomText(
                                '${snapshot.data["strength"]}',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
