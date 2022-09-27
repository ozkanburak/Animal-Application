import 'package:hayvan_uyg/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../main.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final displayNameController = TextEditingController();
  final phoneController = TextEditingController();
  String error = "";
  void register() async {
    User? user = await _auth.registerUser(
        emailController.text,
        passwordController.text,
        displayNameController.text,
        phoneController.text);
    if (user == null) {
      setState(() {
        error = "Lütfen bilgileri doldurunuz";
      });
    } else {
      setState(() {
        error = "";
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Home(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    displayNameController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[800],
          title: const Text("Kayıt Ol")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
              ),
              Image.asset("images/logo.png"),
              
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
                validator: (value) => EmailValidator.validate(value!)
                    ? null
                    : "Lütfen doğru bir e-posta girin",
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Şifre"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir şifre girin';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: displayNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Kullanıcı Adı"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir metin giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text(error),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Kayıt Ol",
                    style: TextStyle(fontSize: 20, letterSpacing: 0.9),
                  ),
                ),
                style: const ButtonStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
