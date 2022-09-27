import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayvan_uyg/pages/login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final dynamic widgetToShow;
  const Wrapper({Key? key, required this.widgetToShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    // Return either provided widget or LoginPage
    if (user != null) {
      return widgetToShow;
    } else {
      return Scaffold(
          appBar: AppBar(
              elevation: 5,
              backgroundColor: Colors.blue[800],
              title: const Text("Lütfen önce giriş yapınız")),
              
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text("Bu sayfayı görebilmek için giriş yapmalısınız",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 55,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: const Text("Giriş Sayfasına Git"))
              ],
            ),
          ));
    }
  }
}
