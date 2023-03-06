import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String email;
  final _auth = FirebaseAuth.instance;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Hi,",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  letterSpacing: 1.9,
                ))),
            Text("Sign Up",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  letterSpacing: 1.9,
                ))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Row(
              children: [
                Text(
                  "Already have an account /",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "login_screen");
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.deepPurple.shade400,
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                    ))
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hoverColor: Colors.deepPurple.shade400,
                  fillColor: Colors.black12,
                  filled: true,

                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(
                  //       color: Colors.grey,
                  //       width: 2.0,
                  //     ),
                  //     borderRadius: BorderRadius.circular(9)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepPurple.shade400,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(9)),
                  hintText: 'Email',
                  alignLabelWithHint: true,
                  label: Icon(
                    Icons.mail,
                    color: Colors.deepPurple.shade400,
                  ),
                  // labelText: "Email"
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.019,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hoverColor: Colors.deepPurple.shade400,
                  fillColor: Colors.black12,
                  filled: true,

                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(
                  //       color: Colors.grey,
                  //       width: 2.0,
                  //     ),
                  //     borderRadius: BorderRadius.circular(9)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepPurple.shade400,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(9)),
                  hintText: 'Password',
                  alignLabelWithHint: true,
                  // labelText: "Password",
                  // labelStyle: TextStyle(
                  //   color: Colors.deepPurple.shade400,
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 20,
                  //   letterSpacing: 1.9,
                  // )
                  label: Icon(
                    Icons.password,
                    color: Colors.deepPurple.shade400,
                  ),
                  // labelText: "Email"
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushReplacementNamed(context, 'home_screen');
                } catch (e) {
                  var error = e.toString().split(']');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      content: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Text(error[1]),
                      ),
                    ),
                  );
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  backgroundColor: Colors.deepPurple.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              child: Text(
                "Register",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
