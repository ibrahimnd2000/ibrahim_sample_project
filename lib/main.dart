import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrahim_sample_project/services/auth_service.dart';
import 'package:ibrahim_sample_project/services/db_service.dart';
import 'package:ibrahim_sample_project/views/home_screen.dart';
import 'package:ibrahim_sample_project/views/login_screen.dart';
import 'package:ibrahim_sample_project/views/register_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        Provider<DBService>(
          create: (_) => DBService(FirebaseFirestore.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        )
      ],
      builder: (context, child) => ScreenUtilInit(
        designSize: Size(1080, 2220),
        builder: () => MaterialApp(
          title: 'Ibrahim Sample Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AuthWrapper(),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key key}) : super(key: key);

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool showRegister = true;

  void switchAuthPage() {
    if (showRegister) {
      setState(() {
        showRegister = false;
      });
    } else {
      setState(() {
        showRegister = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomeScreen();
    }
    return showRegister
        ? RegisterScreen(
            switchAuthPage: switchAuthPage,
          )
        : LoginScreen(
            switchAuthPage: switchAuthPage,
          );
  }
}
