import 'package:hayvan_uyg/pages/createReport.dart';

import 'package:hayvan_uyg/pages/user_profile.dart';
import 'package:hayvan_uyg/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyReports extends StatefulWidget {
  MyReports({Key? key}) : super(key: key);

  @override
  State<MyReports> createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  final _db = DatabaseService();

  String _dropdownvalue = 'My reports';
  var posts = [];
  void onChanged(String? newValue) {
    setState(() {
      _dropdownvalue = newValue!;
    });
  }

  Widget listReports(List<QueryDocumentSnapshot<Object?>> posts, String uid) {
    int maxLengthToShow = 10;
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          String dets = posts[index].get("displayName");
          if (dets.length < maxLengthToShow) {
            maxLengthToShow = dets.length;
          }
          return Card(
              color: Colors.white70,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: OptimizedCacheImageProvider(
                              posts[index].get('images')[0]),
                          radius: 30,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          dets.substring(0, maxLengthToShow) + "...",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              if (await confirm(context,
                                  title: const Text("Onayla"),
                                  content: const Text(
                                      "Bu gönderiyi silmek ister misiniz?"),
                                  textCancel: const Text('İPTAL'))) {
                                _db.deleteReport(posts[index].id);
                              }
                            },
                            icon: const Icon(Icons.delete_forever, size: 35)),
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final reports = Provider.of<QuerySnapshot?>(context);
    final _db = DatabaseService();
    List<QueryDocumentSnapshot<Object?>> savedPosts = [];
    List<QueryDocumentSnapshot<Object?>> ownReports = [];

    for (var report in reports!.docs) {
      if (report.exists && report.get('savedBy').contains(user!.uid)) {
        savedPosts.add(report);
      }
    }

    for (var report in reports.docs) {
      if (report.exists && report.get('uid') == user!.uid) {
        ownReports.add(report);
      }
    }
    //gönderilerim appbar
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        title: Text('Gönderilerim'),
      ),
      body: _dropdownvalue != "My reports"
          ? listReports(savedPosts, user!.uid)
          : listReports(ownReports, user!.uid),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateReportPage()));
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add)),
    );
  }
}
