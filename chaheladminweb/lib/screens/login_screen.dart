import 'package:flutter/material.dart';
import '../general/app_details.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_toast.dart';
import '../widgets/side_navigation_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(200),
                  ),
                ),
                elevation: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image(
                    image: AssetImage(appicon),
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            child: Row(
              children: [
                Expanded(
                    child: CustomTextfield(
                  controller: username,
                  labelText: "Username",
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            child: Row(
              children: [
                Expanded(
                    child: CustomTextfield(
                  controller: password,
                  labelText: "Password",
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            // minWidth: 300,
            height: 45,
            color: Colors.blue,
            child: const Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              if (username.text.isEmpty) {
                erroetoast("Please enter your username");
              } else if (password.text.isEmpty) {
                erroetoast("Please enter your password");
              } else {
                if ("chahel" == username.text.toLowerCase()) {
                  if ("81093879" == password.text.toLowerCase()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CustomSideNavigationBar();
                        },
                      ),
                    );
                  } else {
                    erroetoast("Password is incorrect");
                  }
                } else {
                  erroetoast("Username is incorrect");
                }
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
