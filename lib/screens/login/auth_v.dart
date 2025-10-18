import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/home/home_v.dart';
import 'package:notes_app/screens/login/login_v.dart';

class AuthV extends StatelessWidget {
  const AuthV({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeV();
          }

          return LoginV();
        },
      ),
    );
  }
}
