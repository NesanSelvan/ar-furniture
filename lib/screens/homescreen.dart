import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late User loggedinUser;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  //using this function you can use the credentials of the user

  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade100,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          //Floating action button on Scaffold
          onPressed: () {
            setState(() {
              _currentindex = 5;
            });
          },
          backgroundColor: _currentindex == 5 ? Colors.black : Colors.white,
          child: Center(
            child: IconButton(
              icon: Image.asset(
                "assets/cart.png",
                height: 30,
                width: 25,
                color: _currentindex == 5 ? Colors.white : Colors.red,
              ),
              onPressed: () {
                setState(() {
                  _currentindex = 5;
                });
              },
            ),
          ), //icon inside button
        ),
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              // boxShadow: [
              //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              // ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomAppBar(
                //bottom navigation bar on scaffold
                color: Colors.deepPurple.shade400,

                shape: const CircularNotchedRectangle(), //shape of notch
                notchMargin:
                    7, //notche margin between floating button and bottom appbar
                child: Row(
                  //children inside bottom appbar
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 4, left: 5),
                      child: IconButton(
                        icon: Image.asset(
                          "assets/home.png",
                          height: 25,
                          width: 20,
                          color:
                              _currentindex == 0 ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentindex = 0;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: IconButton(
                        icon: Image.asset(
                          "assets/categories.png",
                          height: 25,
                          width: 20,
                          color:
                              _currentindex == 1 ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentindex = 1;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: IconButton(
                        icon: Icon(
                          Icons.card_giftcard_outlined,
                          color:
                              _currentindex == 2 ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentindex = 2;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          "assets/settings.png",
                          height: 25,
                          width: 20,
                          color:
                              _currentindex == 3 ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentindex = 3;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, "showdata");
                      Navigator.pushNamed(context, "ar_screen");
                    },
                    child: Text("Ar")),
                IconButton(
                    onPressed: () {
                      _signOut();
                      Navigator.pushReplacementNamed(context, "login_screen");
                    },
                    icon: Icon(Icons.logout)),
              ],
            ),
          ),
        ));
  }
}

// class GetUserName extends StatelessWidget {
//   final String documentId = "MLdluph4xQOe8iqH8GIR";

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users =
//         FirebaseFirestore.instance.collection('furnitures');

//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic>? data =
//               snapshot.data?.data() as Map<String, dynamic>?;
//           return Text("Full Name: ${data!['furniture-name']}");
//         }

//         return Text("loading");
//       },
//     );
//   }
// }
// class AddData extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.green,
  //       title: Text("data"),
  //     ),
  //     body: StreamBuilder(
  //       stream: FirebaseFirestore.instance.collection('furnitures').snapshots(),
  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (!snapshot.hasData) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }

  //         return ListView(
  //           children: snapshot.data!.docs.map((document) {
  //             print(document.data());

  //             return Container(
  //               child: Center(child: Text(document['furniture-name'])),
  //             );
  //           }).toList(),
  //         );
  //       },
  //     ),
  //   );
  // }
// }
