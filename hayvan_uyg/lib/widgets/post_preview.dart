import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:hayvan_uyg/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';

import '../pages/PostDetails.dart';

class PostPreview extends StatelessWidget {
  final data, id;

  const PostPreview({Key? key, required this.data, required this.id})
      : super(key: key);
  // Data fields: String uid: user id, List<String> images[]: url for images, String Details
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final _db = DatabaseService();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0, 5.0, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PostDetails(id: id)));
        },
        child: Container(
          height: 200,
          width: 300,
          child: Card(
            elevation: 5.0,
            shadowColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.50,
                  padding: EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: OptimizedCacheImageProvider(data['images'][0]),
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 195,
                  child: GlassContainer(
                    borderRadius: BorderRadius.circular(25),
                    blur: 1,
                    opacity: 0.15,
                    child: Container(
                        width: 180,
                        height: 180,
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  data["displayName"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(Icons.date_range),
                                Text(
                                  data["Cinsiyet"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 45,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                getAttribute(
                                  Icons.male,
                                  data["Tür"],
                                ),
                                getAttribute(
                                  Icons.pets,
                                  data["Konum"],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                getAttribute(
                                  Icons.location_on,
                                  data["Yaş"],
                                ),
                                getAttribute(
                                  Icons.pentagon,
                                  data["Cins"],
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getAttribute(IconData icon, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black87, fontSize: 13),
        ),
      ],
    );
  }
}
