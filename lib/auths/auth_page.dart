import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_asgn_persist/auths/log_or_reg.dart';
import 'package:intern_asgn_persist/helpers/nav_bar.dart';
import 'package:intern_asgn_persist/screens/home_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ScreenController();
          }
          else {
            return const LoginRegisterPath();
          }
        },
      ),
    );
  }
}