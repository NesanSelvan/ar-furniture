import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? model;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final val = await FirebaseFirestore.instance.collection('models').get();

      model = val.docs[0].data()["url"];
      print(model);
      for (var element in val.docs) {
        final dataInDB = element.data();
        print(dataInDB);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
        //   child: Container(
        //     height: MediaQuery.of(context).size.height,
        //     width: MediaQuery.of(context).size.width,
        //     child: StreamBuilder<QuerySnapshot>(
        //         stream: FirebaseFirestore.instance.collection("models").snapshots(),
        //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             return const CircularProgressIndicator();
        //           }
        //           final userSnapshot = snapshot.data?.docs;
        //           if (userSnapshot!.isEmpty) {
        //             return const Text("no data");
        //           }
        //           return Column(
        //             children: <Widget>[
        //               Expanded(
        //                 child: ListView.builder(
        //                     itemCount: userSnapshot.length,
        //                     itemBuilder: (context, index) {
        //                       return Padding(
        //                         padding: const EdgeInsets.symmetric(horizontal: 20),
        //                         child: Container(
        //                           margin: EdgeInsets.only(bottom: 15),
        //                           decoration: BoxDecoration(
        //                               color: Colors.deepPurple.shade400,
        //                               borderRadius: BorderRadius.circular(24)),
        //                           //title: Text(userSnapshot[index]["url"].toString()),
        //                           width: MediaQuery.of(context).size.width * 1,
        //                           height: MediaQuery.of(context).size.height * 0.15,
        //                           child: Center(
        //                               child: Text(userSnapshot[index]["name"])),
        //                         ),
        //                       );
        //                     }),
        //               ),
        //             ],
        //           );
        //         }),
        //   ),
        );
  }
}
