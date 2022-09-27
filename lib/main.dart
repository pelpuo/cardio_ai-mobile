import 'package:cardio_ai/providers/authProvider.dart';
import 'package:cardio_ai/providers/patientProvider.dart';
import 'package:cardio_ai/screens/dashboard.dart';
import 'package:cardio_ai/screens/doctorInfo.dart';
import 'package:cardio_ai/screens/ecgMonitoring.dart';
import 'package:cardio_ai/screens/findPatient.dart';
import 'package:cardio_ai/screens/patientResults.dart';
import 'package:cardio_ai/screens/schedule.dart';
import 'package:cardio_ai/screens/signIn.dart';
import 'package:cardio_ai/screens/signUp.dart';
import 'package:cardio_ai/widgets/patientCard.dart';
import 'package:cardio_ai/wrappers/authWrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Cardio AI",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}
