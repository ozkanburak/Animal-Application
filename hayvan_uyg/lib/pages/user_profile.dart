import 'dart:developer';

import 'package:hayvan_uyg/pages/MainPage.dart';
import 'package:hayvan_uyg/services/auth.dart';
import 'package:hayvan_uyg/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return user != null
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.blue[800],
              title: const Text("Profil"),
            ),
            body: Column(
              children: [
                const SizedBox(height: 80.0),
                Image.asset("images/logo.png",
                ),
                const SizedBox(height: 50.0),
                Text(user.displayName ?? 'Bir kullanıcı adı belirleyin'),
                const SizedBox(height: 20.0),
                Text(user.email ?? 'Bir e-posta belirleyin'),
                const SizedBox(height: 20.0),
                Center(
                    child: ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));
                  },
                  child: const Text("Çıkış"),
                )),
              ],
            ),
          )
        : const Text("Yükleniyor");
  }
}
