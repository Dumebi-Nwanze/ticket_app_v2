import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_v2/custom_widgets/snackbar.dart';
import 'package:ticket_app_v2/screens/home_screen.dart';
import 'package:ticket_app_v2/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAu_n6Hsoq-7_lY8BTqCA4XQBrvOest8Fk",
        appId: "1:340824785783:web:bcf27de8e163a63ea6d772",
        messagingSenderId: "340824785783",
        projectId: "ticketappv2-270f5",
        storageBucket: "ticketappv2-270f5.appspot.com",
        authDomain: "ticketappv2-270f5.firebaseapp.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicketsV2',
      theme: ThemeData(
        fontFamily: "AvenirNext",
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: _auth.authStateChanges(), //stream source
        builder: (context, snapshot) {
          //check state of the connection
          if (snapshot.connectionState == ConnectionState.active) {
            //return something is the snap has data
            if (snapshot.hasData) {
              return HomeScreen();
            } else if (snapshot.hasError) {
              //return a snackbar with the error
              return snackBar(context, snapshot.error.toString());
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            //load screen
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            );
          } //if no connection return login screen
          return LoginScreen();
        },
      ),
    );
  }
}
