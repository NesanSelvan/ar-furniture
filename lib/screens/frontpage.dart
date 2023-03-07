import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatefulWidget {
  FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final _auth = FirebaseAuth.instance;
  String? model;
  var _currentindex;
  @override
  void initState() {
    super.initState();
    print("index" + _currentindex.toString());
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final val = await FirebaseFirestore.instance.collection('models').get();

      model = val.docs[_currentindex].data()["url"];
      print(model);
      for (var element in val.docs) {
        final dataInDB = element.data();
        print(dataInDB);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("models").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final userSnapshot = snapshot.data?.docs;
          if (userSnapshot!.isEmpty) {
            return const Text("no data");
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                //color: Colors.black26,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: userSnapshot.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _currentindex = index;
                        print("index ${userSnapshot[index].data()}");
                        final data = userSnapshot[index].data();
                        if (data is Map<String, dynamic>) {
                          if (data.containsKey('url')) {
                            Navigator.pushNamed(context, "ar_screen",
                                arguments: {
                                  "url": data['url'],
                                });
                          }
                        }
                        setState(() {});
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Container(
                          // width:
                          //     (MediaQuery.of(context).size.width * 0.5) - 15,
                          // height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://imgmedia.lbb.in/media/2022/05/62736afa42d07e2c4a83ea34_1651731194487.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.black,
                                    const Color(0x19000000),
                                  ],
                                  begin: const FractionalOffset(0.0, 1.0),
                                  end: const FractionalOffset(0.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  userSnapshot[index]["name"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },

                  // itemCount: userSnapshot.length,
                  // // itemBuilder: (context, index) {
                  // children: [
                  //   Container(
                  //     margin: EdgeInsets.only(bottom: 15),
                  //     decoration: BoxDecoration(
                  //         color: Colors.deepPurple.shade400,
                  //         borderRadius: BorderRadius.circular(24)),
                  //     //title: Text(userSnapshot[index]["url"].toString()),
                  //     width: MediaQuery.of(context).size.width * 1,
                  //     height: MediaQuery.of(context).size.height * 0.15,
                  //     child: Center(child: Text(userSnapshot[0]["name"])),
                  //   ),
                  // ]
                ),
              ),
            ),
          );
        });
  }
}
