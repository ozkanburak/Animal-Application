import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hayvan_uyg/pages/user_profile.dart';
import 'package:hayvan_uyg/widgets/reportList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 25, // VOITHA EAN VGALOUME TO SIZEBOX
        backgroundColor: Colors.blue[800],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pet Needs", style: TextStyle(color: Colors.white)),
            user != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfile()));
                    },
                    child: const Icon(
                      Icons.manage_accounts,
                      size: 30,
                    ))
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: const Icon(Icons.account_circle, size: 30)),
          ],
        ),
      ),
      body: Column(children: const [SizedBox(height: 10), ReportList()]),
    );
  }
}
