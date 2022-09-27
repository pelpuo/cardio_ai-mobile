import 'package:cardio_ai/providers/authProvider.dart';
import 'package:cardio_ai/screens/dashboard.dart';
import 'package:cardio_ai/screens/signIn.dart';
import 'package:cardio_ai/screens/signUp.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    bool signedIn = Provider.of<AuthProvider>(context).signedIn;
    String authState = Provider.of<AuthProvider>(context).authState;
    bool tokenChecked = Provider.of<AuthProvider>(context).tokenChecked;

    if (!tokenChecked) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: appColors.blue,
          ),
        ),
      );
    } else {
      if (signedIn) {
        return const Dashboard();
      } else if (authState == "signIn") {
        return const SignIn();
      } else {
        return const SignUp();
      }
    }
  }
}
