import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_health_app/models/user.dart';
import 'package:pet_health_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_health_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:pet_health_app/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      // adding because of eroor
      initialData: null,
      // until here adding because of error

      child: MaterialApp(
        home: Wrapper(),
      ),
      catchError: (_, __) => null,
    );
  }
}
