import 'package:arcore_flutter_plugin_example/screens/categorypage.dart';
import 'package:arcore_flutter_plugin_example/screens/frontpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

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

  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  late String title;

  @override
  void initState() {
    title = "home";
    super.initState();
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
              color: _currentindex == 5
                  ? Colors.white
                  : Colors.deepPurple.shade400,
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
                        color: _currentindex == 0 ? Colors.black : Colors.white,
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
                        color: _currentindex == 1 ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        //   Navigator.pushNamed(context, "category_screen");
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
                        color: _currentindex == 2 ? Colors.black : Colors.white,
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
                        color: _currentindex == 3 ? Colors.black : Colors.white,
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
      body: Container(
        child: SliderDrawer(
            sliderBoxShadow: SliderBoxShadow(color: Colors.deepPurple.shade200),
            // animationDuration: 100,
            appBar: SliderAppBar(
                appBarPadding:
                    EdgeInsets.symmetric(vertical: 45, horizontal: 10),
                drawerIconSize: 35,
                drawerIconColor: Colors.deepPurple.shade400,
                appBarHeight: MediaQuery.of(context).size.height * 0.14,
                appBarColor: Colors.deepPurple.shade100,
                title: Text(title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700))),
            key: _sliderDrawerKey,
            sliderOpenSize: 240,
            slider: _SliderView(
              onItemClick: (title) async {
                _sliderDrawerKey.currentState!.closeSlider();

                if (title == "LogOut") {
                  await _signOut();
                  Navigator.pushReplacementNamed(context, "login_screen");
                }
                setState(() {
                  this.title = title;
                });
              },
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_currentindex == 0)
                    FrontPage()
                  else if (_currentindex == 1)
                    CategoryPage()
                ],
              ),
            )),
      ),
    );
  }
}

class _SliderView extends StatefulWidget {
  final Function(String)? onItemClick;
  _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  State<_SliderView> createState() => _SliderViewState();
}

late String userEmail;
final _auth = FirebaseAuth.instance;
var name;
var onlyname;

class _SliderViewState extends State<_SliderView> {
  @override
  void initState() {
    dynamic user = _auth.currentUser;
    userEmail = user.email;
    name = userEmail.toString().split("@");
    onlyname = name[0].toString().split(RegExp(r"[0-9]"))[0];
    print(name[0].toString().split(RegExp(r"[0-9]"))[1]);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.8,
      color: Colors.deepPurple.shade100,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.deepPurple.shade400,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: Image.asset('assets/earth.jpg').image,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // IconButton(
          //     onPressed: () {
          //       print(name[0].toString().split(RegExp(r"[0-9]"))[9]);
          //     },
          //     icon: Icon(Icons.access_alarms_outlined)),
          Text(
            // "nesan",
            name[0].toString().split(RegExp(r"[0-9]"))[0] == ""
                ? name[0].toString().split(RegExp(r"[0-9]"))[9]
                : name[0].toString().split(RegExp(r"[0-9]"))[0],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...[
            Menu(Icons.home, 'Home'),
            Menu(Icons.add_circle, 'Add Post'),
            Menu(Icons.notifications_active, "Notifications"),
            Menu(Icons.favorite, 'Likes'),
            Menu(Icons.settings, 'Setting'),
            Menu(Icons.arrow_back_ios, 'LogOut')
          ]
              .map((menu) => _SliderMenuItem(
                  title: menu.title,
                  iconData: menu.iconData,
                  onTap: widget.onItemClick))
              .toList(),
        ],
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function(String)? onTap;

  const _SliderMenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
        leading: Icon(iconData, color: Colors.black),
        onTap: () => onTap?.call(title));
  }
}

class Menu {
  final IconData iconData;
  final String title;

  Menu(this.iconData, this.title);
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
