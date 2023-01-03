import 'package:crud_api_product_list/main.dart';
import 'package:crud_api_product_list/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  static String KEYNAME = "name";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter name.",
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter password.",
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                // If Successfully Logged in (Creds are Correct)
                // Obtain shared preferences.
                final sharedprefs = await SharedPreferences.getInstance();
                // Save an boolean value to "" key.
                sharedprefs.setBool(SplashPageState.KEYLOGIN, true);
                // Save an String Value to "" key.
                sharedprefs.setString(KEYNAME, nameController.text.toString());
                //
                setState(() {
                  sharedprefs.getString(KEYNAME);
                });

                //
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Text("Login"),
            ),
          ],
        ),
      )),
    );
  }
}
