import 'package:cardio_ai/providers/authProvider.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:cardio_ai/widgets/appTextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.offWhite,
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) => SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(24),
                child: auth.signingIn
                    ? const SpinKitFadingFour(
                        color: appColors.blue,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Image.asset(
                            "assets/logo.png",
                            width: 540 / 5,
                            height: 476 / 5,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            "Welcome back!",
                            style:
                                TextStyle(fontSize: 24, color: appColors.green),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          AppTexInput(
                              textController: userNameController,
                              prompt: "Username",
                              onPressed: () {}),
                          const SizedBox(
                            height: 18,
                          ),
                          AppTexInput(
                              textController: passwordController,
                              prompt: "Password",
                              hideText: true,
                              onPressed: () {}),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: appColors.green),
                                )),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                child: TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(32))),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(20)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                appColors.blue)),
                                    onPressed: () async {
                                      bool loginSuccess = await auth.loginUser(
                                          userNameController.text.trim(),
                                          passwordController.text.trim());
                                      // auth.setSignedIn(true);

                                      if (!loginSuccess) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          auth.authErrors,
                                          textAlign: TextAlign.center,
                                        )));
                                      }
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: appColors.appWhite,
                                          fontSize: 16),
                                    )),
                              ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("New here?"),
                              TextButton(
                                  onPressed: () {
                                    auth.setAuthState("signUp");
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(color: appColors.green),
                                  ))
                            ],
                          )
                        ],
                      ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
