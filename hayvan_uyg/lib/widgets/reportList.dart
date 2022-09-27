import 'package:hayvan_uyg/widgets/post_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    final reports = Provider.of<QuerySnapshot?>(context);

    if (reports != null) {
      return Expanded(
          child: PaginateFirestore(
        itemsPerPage: 3,
        itemBuilder: (context, reports, index) {
          final data = reports[index];
          return PostPreview(data: data, id: reports[index].id);
        },
        query: FirebaseFirestore.instance
            .collection('Report')
            .orderBy('createdAt', descending: true),
        itemBuilderType: PaginateBuilderType.listView,
        isLive: true,
      ));
    } else {
      return Text("Yükleniyor");
    }
  }
}
