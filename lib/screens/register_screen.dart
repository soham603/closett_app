import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_asgn_persist/helpers/database_auth.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const RegisterScreen({super.key, required this.onClickedSignUp});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController passconfirmcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color.fromARGB(255, 164, 165, 255),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),

                Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 120,
                          width: 150,
                          child: Image.asset('assets/logo.jpg'),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "To Do APP",
                        style: GoogleFonts.lato(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20,)
                    ],
                  ),
                ),

                Container(
                  width: 350,
                  height: 570,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.red,
                        width: 3
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        const Text('Kindly Register!', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 25,),
                        TextFormField(
                          focusNode: _focusNode4,
                          controller: namecontroller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 3,
                                )
                            ),
                            hintText: "Name",
                            label: const Text("Enter Name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(Icons.person),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          focusNode: _focusNode1,
                          controller: mailcontroller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 3,
                                )
                            ),
                            hintText: "abc@gmail.com",
                            label: const Text("Enter Email"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon:  const Icon(Icons.mail,),
                          ),
                          obscureText: false,
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          focusNode: _focusNode2,
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 3,
                                )
                            ),
                            hintText: "Password",
                            label: const Text("Enter Password"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(Icons.key),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          focusNode: _focusNode3,
                          controller: passconfirmcontroller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 3,
                                )
                            ),
                            hintText: "Password",
                            label: const Text("Enter Password Again"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(Icons.key),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 15,),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.redAccent,
                          child: MaterialButton(
                            minWidth: 375,
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            onPressed: () {
                              AuthenticationRemote().register(namecontroller.text,mailcontroller.text, passwordcontroller.text, passconfirmcontroller.text);
                            },
                            child: const Text(style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),"Register", textAlign: TextAlign.center,),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const Text("OR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        const SizedBox(height: 10,),
                        RichText(
                            text: TextSpan(
                                text: "Already have an Account? ",
                                style: const TextStyle(color: Colors.black, fontSize: 16),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                                    text: 'Log In',
                                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ]
                            )
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          )
      ),
    );
  }
}
