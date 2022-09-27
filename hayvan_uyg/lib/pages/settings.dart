import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  State<SettingsPage> createState() => _SettingsPageState();
}

bool isplaying = false;

class _SettingsPageState extends State<SettingsPage> {
  String istapped = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
            backgroundColor: Colors.blue.shade800,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.blue[800],
              title: Text('Hakkımızda'),
            ),
            body: Center(
                child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 560,
                    width: 400,
                    child: Column(
                      children: [
                        Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Evcil hayvan dostlarımızın sahiplendirilmesi ve eş bulabilmesi için geliştirilen bir mobil uygulamadır. Uygulamamızda ilanlardaki özellikleri detaylıca inceleyerek evcil dostunuz için en ideal eşi bulabilirsiniz.Uygulama içi iletişim bilgileri mevcuttur, güvenilir bir şekilde görüşmelerinizi sağlayabilirsiniz.Uygulamamız tamamen ücretsizdir. Bize bağışta bulunarak uygulamamızın gelişmesine destek olabilirsiniz.',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // ElevatedButton
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue[800]),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        fontSize: 14, color: Colors.white))),
                            onPressed: () {
                              setState(() {
                                istapped =
                                    'Yakında Aktif olacak';
                              });
                            },
                            child: const Text('Bağışta Bulun')),
                        const SizedBox(height: 20),
                        Text(
                          istapped,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ],
            ))),
      ],
    );
  }
}
