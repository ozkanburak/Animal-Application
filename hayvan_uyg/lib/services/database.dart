import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class DatabaseService {
  DatabaseService();
  final CollectionReference reportsCollection =
      FirebaseFirestore.instance.collection('Report');

  final Reference storage = FirebaseStorage.instance.ref();
  
 
  Future<void> deleteReport(String rid) {
    return reportsCollection.doc(rid).delete();
  }

  
  

  Future<String> uploadImage(String path) async {
    File file = File(path);
    String randomId = uuid.v1();
    try {
      await storage.child("uploads/" + randomId).putFile(file);
    } catch (err) {
      print(err.toString());
      return '';
    }
    return await storage.child('uploads/' + randomId).getDownloadURL();
  }

  Future addReportData(
      List<String> imgPaths,
      String uid,
      String dets,
      int createdAt,
      String? cinsiyet,
      String? konum,
      String? cins,
      String? tur,
      String? yas,
      String phone,
      String displayName) async {
    try {
      List<String> imgUrls = [];
      for (var path in imgPaths) {
        String imageUrl = await uploadImage(path);
        imgUrls.add(imageUrl);
      }
      await reportsCollection.add({
        'uid': uid,
        'Ayrıntı': dets,
        'images': imgUrls,
        'createdAt': createdAt,
        'phone': phone,
        "savedBy": [],
        "Cins": cins,
        "Konum": konum,
        "Tür": tur,
        "Cinsiyet": cinsiyet,
        "displayName": displayName,
        "Yaş": yas,
        
        
      });
      return "Success";
    } catch (e) {
      return "Error";
    }
  }

  Future updateReportData(
      String docId, 
      String uid, 
      String dets, 
      String? cinsiyet,
      String? konum,
      String? cins,
      String? tur,
      String? yas,
      
      ) async {
    return await reportsCollection.doc(docId).update({
      'uid': uid,
      'Ayrıntı': dets,
      "Cins": cins,
      "Konum": konum,
      "Tür": tur,
      "Cinsiyet": cinsiyet,
      "Yaş": yas,

    });
  }

  

  Stream<QuerySnapshot?> get reports {
    return reportsCollection.snapshots();
  }
}
