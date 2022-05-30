import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/backend/authntification/authntification_serivice.dart';
import 'package:flutter_login_ui/providers/location.dart';
import 'package:flutter_login_ui/providers/user_model.dart';
import 'package:flutter_login_ui/screens/auth/login_page.dart';
import 'package:flutter_login_ui/screens/dashboad/dashboard.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MakeComplainant()),
      ChangeNotifierProvider(create: (context) => UserModel()),
    ],
    child: Builder(builder: (BuildContext newContext) {
      return LoginUiApp();
    }),
  ));
}

class LoginUiApp extends StatelessWidget {
  Color primaryColor = HexColor('#189AB4');
  Color accentColor = HexColor('#75E6DA');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login UI',
        theme: ThemeData(
          primaryColor: primaryColor,
        ),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data!.uid;
                return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user)
                      .get(),
                  builder: (context, snapshotuture) {
                    if (snapshotuture.connectionState == ConnectionState.done) {
                      final userData = snapshotuture.data;

                      Map<String, dynamic> data =
                          userData!.data() as Map<String, dynamic>;
                      String rr = data['role'];
                      if (rr == 'citizen') {
                        return DashboardUser();
                      }
                      return Scaffold(body: LoginPage());
                    } else
                      return Scaffold(
                          body: Center(child: CircularProgressIndicator()));
                  },
                );
              } else {
                return Scaffold(body: LoginPage());
              }
            })
        // home: SplashScreen(title: 'Flutter Login UI'),

        );
  }
}
