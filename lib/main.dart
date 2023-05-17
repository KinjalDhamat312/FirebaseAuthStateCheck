import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Firebase Auth'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Auth Demo",
        ),
        actions: [
          StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                return TextButton(
                  onPressed: () async {
                    snapshot.data != null ? logout() : openAuthScreen();
                  },
                  child: Text(
                    snapshot.data != null ? "Logout" : "Login",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              "Method 1",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                return Text(
                  "User Detail: ${snapshot.data != null ? snapshot.data?.email : "User not found"}",
                  textAlign: TextAlign.center,
                );
              }),
          const Padding(
            padding: EdgeInsets.only(top: 70.0, bottom: 30),
            child: Text(
              "Method 2",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "User Detail: ${FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser?.email : "User not found"}",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    setState(() {});
  }

  void openAuthScreen() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AuthPage()));
    setState(() {});
  }
}
