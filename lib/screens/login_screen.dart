import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_asgn_persist/helpers/database_auth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginScreen({super.key, required this.onClickedSignUp});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 164, 165, 255),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 170,
                          width: 200,
                          child: Icon(Icons.star)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "To Do APP",
                        style: GoogleFonts.lato(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  height: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.deepOrange,
                      width: 3, // You can adjust the width of the border as needed
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Welcome! Login',
                          style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: mailcontroller,
                          focusNode: _focusNode1,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 3,
                                )),
                            hintText: "abc@gmail.com",
                            label: const Text("Enter Email"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(
                              Icons.mail,
                              color:
                              _focusNode1.hasFocus ? Colors.green : Colors.grey,
                            ),
                          ),
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          focusNode: _focusNode2,
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 3,
                                )),
                            hintText: "Password",
                            label: const Text("Enter Password"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(
                              Icons.key,
                              color:
                              _focusNode2.hasFocus ? Colors.green : Colors.grey,
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.redAccent,
                          child: MaterialButton(
                            minWidth: 375,
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            onPressed: () {
                              AuthenticationRemote().login(
                                  mailcontroller.text, passwordcontroller.text);
                            },
                            child: const Text(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              "Login",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "OR",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Register',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignUp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
