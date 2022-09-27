import 'package:cardio_ai/providers/authProvider.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:cardio_ai/widgets/appTextInput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final double inputSpacing = 18;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: inputSpacing,
                    ),
                    const Text(
                      "Create your account",
                      style: TextStyle(fontSize: 24, color: appColors.green),
                    ),
                    SizedBox(
                      height: inputSpacing,
                    ),
                    AppTexInput(
                        textController: firstNameController,
                        prompt: "First name",
                        onPressed: () {}),
                    AppTexInput(
                        textController: lastNameController,
                        prompt: "Last name",
                        onPressed: () {}),
                    SizedBox(
                      height: inputSpacing,
                    ),
                    AppTexInput(
                        textController: emailController,
                        prompt: "E-mail",
                        onPressed: () {}),
                    SizedBox(
                      height: inputSpacing,
                    ),
                    AppTexInput(
                        textController: passwordController,
                        prompt: "Password",
                        hideText: true,
                        onPressed: () {}),
                    SizedBox(
                      height: inputSpacing,
                    ),
                    AppTexInput(
                        textController: confirmPasswordController,
                        prompt: "Confirm Password",
                        hideText: true,
                        onPressed: () {}),
                    const SizedBox(
                      height: 36,
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
                                  backgroundColor: MaterialStateProperty.all(
                                      appColors.blue)),
                              onPressed: () async {
                                if (emailController.text.trim() == "" ||
                                    passwordController.text.trim() == "" ||
                                    firstNameController.text.trim() == "" ||
                                    lastNameController.text.trim() == "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text(
                                    "All fields must be filled",
                                    textAlign: TextAlign.center,
                                  )));
                                  return;
                                }

                                if (passwordController.text.trim() !=
                                    confirmPasswordController.text.trim()) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text(
                                    "Passwords do not match",
                                    textAlign: TextAlign.center,
                                  )));

                                  return;
                                }

                                await auth.registerUser(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    firstNameController.text.trim(),
                                    lastNameController.text.trim());
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: appColors.appWhite, fontSize: 16),
                              )),
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already a user?",
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {
                              auth.setAuthState("signIn");
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  color: appColors.green, fontSize: 14),
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
