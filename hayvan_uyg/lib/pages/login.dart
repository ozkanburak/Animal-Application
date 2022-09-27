import 'package:hayvan_uyg/pages/MainPage.dart';
import 'package:hayvan_uyg/pages/register.dart';
import 'package:hayvan_uyg/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  bool failedLogin = false;

  void login() async {
    User? user = await _auth.signInEmailPassword(
        idController.text, passwordController.text);
    if (user == null) {
      setState(() {
        failedLogin = true;
      });
    } else {
      setState(() {
        failedLogin = false;
      });
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    }
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue[800],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Giriş"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.person, color: Colors.black),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Kayıt Ol",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ))
              ],
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(
              children: [
                Image.asset("images/logo.png"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 10),
                  child: TextFormField(
                    controller: idController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "E-posta Girin"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    obscuringCharacter: '*',
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Şifre Girin"),
                  ),
                ),
                failedLogin
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Yanlış kimlik bilgileri",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1),
                        ))
                    : const Text(""),
                ElevatedButton(
                  onPressed: login,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Giriş",
                      style: TextStyle(fontSize: 20, letterSpacing: 1.1),
                    ),
                  ),
                  style: const ButtonStyle(),
                )
              ],
            ),
          ),
        ));
  }
}
