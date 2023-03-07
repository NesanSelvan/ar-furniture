import 'package:arcore_flutter_plugin_example/screens/ar_screen.dart';
import 'package:arcore_flutter_plugin_example/screens/homescreen.dart';
import 'package:arcore_flutter_plugin_example/screens/loginpage.dart';
import 'package:arcore_flutter_plugin_example/screens/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print('ARCORE IS AVAILABLE?');
  // print(await ArCoreController.checkArCoreAvailability());
  print('\nAR SERVICES INSTALLED?');
  //print(await ArCoreController.checkIsArCoreInstalled());
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? 'login_screen'
          : 'home_screen',
      onGenerateRoute: (settings) {
        late Widget currentScreen;
        switch (settings.name) {
          case 'registration_screen':
            currentScreen = SignIn();
            break;
          case 'login_screen':
            currentScreen = LoginPage();
            break;
          case 'home_screen':
            currentScreen = HomeScreen();
            break;
          case 'ar_screen':
            final args = settings.arguments as Map<String, dynamic>;

            currentScreen = ArScreen(
              url: args["url"].toString(),
            );
            break;
          default:
            currentScreen = SignIn();
            break;
        }
        return MaterialPageRoute(builder: (context) => currentScreen);
      },
    );
  }
}

// //ignore this
// // class HelloWorld extends StatefulWidget {
// //   @override
// //   _HelloWorldState createState() => _HelloWorldState();
// // }

// // class _HelloWorldState extends State<HelloWorld> {
// //   late ArCoreController arCoreController;

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Hello World'),
// //         ),
// //         body: ArCoreView(
// //           onArCoreViewCreated: _onArCoreViewCreated,
// //         ),
// //       ),
// //     );
// //   }

// //   void _onArCoreViewCreated(ArCoreController controller) {
// //     arCoreController = controller;

// //     _addSphere(arCoreController);
// //     _addCylindre(arCoreController);
// //     _addCube(arCoreController);
// //   }

// //   void _addSphere(ArCoreController controller) {
// //     final material = ArCoreMaterial(color: Color.fromARGB(120, 66, 134, 244));
// //     final sphere = ArCoreSphere(
// //       materials: [material],
// //       radius: 0.1,
// //     );
// //     final node = ArCoreNode(
// //       shape: sphere,
// //       position: vector.Vector3(0, 0, -1.5),
// //     );
// //     controller.addArCoreNode(node);
// //   }

// //   void _addCylindre(ArCoreController controller) {
// //     final material = ArCoreMaterial(
// //       color: Colors.red,
// //       reflectance: 1.0,
// //     );
// //     final cylindre = ArCoreCylinder(
// //       materials: [material],
// //       radius: 0.5,
// //       height: 0.3,
// //     );
// //     final node = ArCoreNode(
// //       shape: cylindre,
// //       position: vector.Vector3(0.0, -0.5, -2.0),
// //     );
// //     controller.addArCoreNode(node);
// //   }

// //   void _addCube(ArCoreController controller) {
// //     final material = ArCoreMaterial(
// //       color: Color.fromARGB(120, 66, 134, 244),
// //       metallic: 1.0,
// //     );
// //     final cube = ArCoreCube(
// //       materials: [material],
// //       size: vector.Vector3(0.5, 0.5, 0.5),
// //     );
// //     final node = ArCoreNode(
// //       shape: cube,
// //       position: vector.Vector3(-0.5, 0.5, -3.5),
// //     );
// //     controller.addArCoreNode(node);
// //   }

// //   @override
// //   void dispose() {
// //     arCoreController.dispose();
// //     super.dispose();
// //   }
// // }
