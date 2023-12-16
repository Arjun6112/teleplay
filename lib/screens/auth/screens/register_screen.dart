import 'package:flutter/material.dart';
import 'package:teleplay/components/common_button.dart';
import 'package:teleplay/components/common_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade300,
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.video_collection, size: 50, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                CommonTextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  hintText: "User ID",
                ),
                CommonTextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  hintText: "Password",
                ),
                const SizedBox(
                  height: 40,
                ),
                CommonButton(
                  title: "Login",
                  onPressed: () {},
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue.shade900),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 2.0,
                  color: Colors.blue[700],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member ?",
                      style:
                          TextStyle(color: Colors.blue.shade700, fontSize: 18),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Join Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }
}
