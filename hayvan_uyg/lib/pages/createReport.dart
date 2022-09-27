import 'package:hayvan_uyg/main.dart';
import 'package:hayvan_uyg/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({Key? key}) : super(key: key);

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final detailsControler = TextEditingController();
  final turControler = TextEditingController();
  final cinsControler = TextEditingController();
  final locationControler = TextEditingController();
  final displayNameControler = TextEditingController();
  final yasController = TextEditingController();
  final cinsiyetControler = TextEditingController();
  final phoneController = TextEditingController();
  

  final _picker = ImagePicker();
  final DatabaseService _database = DatabaseService();
  String errorMessage = "";
  String getImgNames() {
    String imgNames = "";
    for (var img in images!) {
      imgNames += img.name + ",";
    }
    return imgNames;
  }

  List<XFile>? images = [];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    displayNameControler.text = user!.displayName ?? "";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        title: const Text('Evcil Hayanınız Ekleyin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Form(
              child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Boş Yerleri Doldurunuz!';
                  }
                  return null;
                },
                controller: displayNameControler,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Kullanıcı Adı"),
              ),
              const SizedBox(
                height: 5,
              ),
               TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Boş Yerleri Doldurunuz!';
                  }
                  return null;
                },
                controller: phoneController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Telefon"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Boş Yerleri Doldurunuz!';
                  }
                  return null;
                },
                controller: locationControler,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Konum"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Boş Yerleri Doldurunuz!';
                  }
                  return null;
                },
                controller: turControler,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Tür"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: cinsControler,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Cins"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: cinsiyetControler,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Cinsiyet"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: yasController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Yas"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Boş Yerleri Doldurunuz!';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                controller: detailsControler,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Ayrıntı"),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    var _local = await _picker.pickMultiImage(imageQuality: 100);
                    setState(() {
                      images = _local;
                    });
                  },
                  child: const Text("Resim Yükleyiniz")),
              const SizedBox(
                height: 30,
              ),
              images != null && images!.isNotEmpty
                  ? Text(
                      "Seçilen Resim: " + getImgNames(),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    )
                  : const Text(""),
              ElevatedButton(
                  onPressed: () async {
                    List<String> paths = [];
                    for (var image in images!) {
                      paths.add(image.path);
                    }
                    if (paths.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Resim gerekli!"),
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.blue,
                        behavior: SnackBarBehavior.floating,
                      ));
                      return;
                    }
                    try {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Yükleniyor ..."),
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.blue,
                        behavior: SnackBarBehavior.floating,
                      ));
                      await _database.addReportData(
                          paths,
                          user.uid,
                          detailsControler.text,
                          DateTime.now().millisecondsSinceEpoch,
                          yasController.text,
                          turControler.text,
                          cinsControler.text,
                          cinsiyetControler.text,
                          locationControler.text,
                          phoneController.text,
                          displayNameControler.text);
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    } catch (e) {
                      setState(() {
                        errorMessage = "Bir şeyler ters gitti, daha sonra tekrar deneyin";
                      });
                      print(e.toString());
                      return;
                    }
                  },
                  child: const Text("Gönder")),
              Text(errorMessage)
            ],
          )),
        ),
      ),
    );
  }
}
