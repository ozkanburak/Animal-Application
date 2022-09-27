import 'dart:io';
import 'package:flutter/painting.dart';
import 'package:hayvan_uyg/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class PostDetails extends StatefulWidget {
  final id;
  const PostDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    final reports = Provider.of<QuerySnapshot?>(context);
    final user = Provider.of<User?>(context);
    final _db = DatabaseService();
    var data = reports?.docs.firstWhereOrNull((useDocument) {
      return useDocument.id == widget.id;
    });
    if (data != null && data.exists) {
      bool isSaved =
          user != null ? data.get('savedBy').contains(user.uid) : false;
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: ClipRRect(
                          child: Image(
                            width: 1000,
                            image: OptimizedCacheImageProvider(
                                data.get('images')[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60.0),
                                topRight: Radius.circular(60.0)),
                          ),
                          child: const SizedBox(width: 1),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 0,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data['displayName'],
                          style: const TextStyle(
                              fontSize: 28.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2),
                        ),        
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            Text(
                              data['Yaş'],
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.grey),
                            ),
                            const SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.male,
                                  color: Colors.grey,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 2.0),
                                Text(
                                  data['Tür'],
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16.0),
                                ),
                                const SizedBox(width: 20.0),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.pentagon,
                                      color: Colors.grey,
                                      size: 16.0,
                                    ),
                                    const SizedBox(width: 2.0),
                                    Text(
                                      data['Cins'],
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 16.0),
                                    ),
                                    const SizedBox(width: 20.0),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        const Icon(
                                          Icons.date_range,
                                          color: Colors.grey,
                                          size: 16.0,
                                        ),
                                        const SizedBox(width: 2.0),
                                        Text(
                                          data['Cinsiyet'],
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
               
                Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          child: SizedBox(
                            height: 150,
                            width: 350,
                            child: Text(
                              data['Ayrıntı'],
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 0,
                ),
                SizedBox(
                  height: 87,
                  child: Card(
                      margin: EdgeInsets.all(18),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Icon(
                            Icons.phone,
                          )),
                          title: Text(
                            data['phone'],
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 29, color: Colors.white),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.blue[800],
              title: const Text("Gönderi Ayrıntıları")),
          body: const Center(child: Text("Yükleniyor...")));
    }
  }
}
