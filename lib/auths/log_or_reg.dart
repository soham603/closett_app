import 'package:flutter/material.dart';
import 'package:intern_asgn_persist/screens/login_screen.dart';
import 'package:intern_asgn_persist/screens/register_screen.dart';
class LoginRegisterPath extends StatefulWidget {
  const LoginRegisterPath({super.key});

  @override
  State<LoginRegisterPath> createState() => _LoginRegisterPathState();
}

class _LoginRegisterPathState extends State<LoginRegisterPath> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
      isLogin ? LoginScreen(onClickedSignUp: toggle) :
      RegisterScreen(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
