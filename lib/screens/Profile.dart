import 'package:cardio_ai/providers/patientProvider.dart';
import 'package:cardio_ai/screens/schedule.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:cardio_ai/widgets/appTextInput.dart';
import 'package:cardio_ai/widgets/recentCard.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List patients = [
    "Peter Doe",
    "James Doe",
    "John Doe",
    "Sandra Doe",
    "Martha Doe",
    "Alison Doe",
    "Cynthia Doe"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _selectedValue;

    TextEditingController firstNameController = TextEditingController(
        text: Provider.of<PatientProvider>(context, listen: false)
                .currentUser
                ?.firstName ??
            "");
    TextEditingController lastNameController = TextEditingController(
        text: Provider.of<PatientProvider>(context, listen: false)
                .currentUser
                ?.lastName ??
            "");
    TextEditingController emailController = TextEditingController(
        text: Provider.of<PatientProvider>(context, listen: false)
                .currentUser
                ?.email ??
            "");

    return Scaffold(
      backgroundColor: appColors.offWhite,
      body: Consumer<PatientProvider>(
        builder: (context, patientBase, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    height: height * .35,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/doctor.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: appColors.blue,
                    ),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Dr. ${patientBase.currentUser!.firstName} ${patientBase.currentUser!.lastName}",
                            style: const TextStyle(
                                fontSize: 24,
                                color: appColors.appWhite,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Heart Surgeon",
                            style: TextStyle(
                                fontSize: 14, color: appColors.appWhite),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.place,
                                color: appColors.appWhite,
                                size: 24,
                              ),
                              Text(
                                "Korle Bu Teaching Hospital",
                                style: TextStyle(
                                    fontSize: 14, color: appColors.appWhite),
                              ),
                              SizedBox(
                                width: 24,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ]),
                  ),
                )
              ],
            ),
            // About Section

            const SizedBox(
              height: 24,
            ),
            // Recent Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Edit Details",
                    style: TextStyle(
                        fontSize: 24,
                        color: appColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        // backgroundColor: appColors.blue,
                        side: const BorderSide(color: appColors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(color: appColors.blue, fontSize: 16),
                      ))
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, bottom: 16, right: 16),
                child: ListView(
                  children: [
                    AppTexInput(
                        textController: firstNameController,
                        prompt: "First Name",
                        onPressed: () {}),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTexInput(
                        textController: lastNameController,
                        prompt: "Last Name",
                        onPressed: () {}),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTexInput(
                        textController: emailController,
                        prompt: "Email",
                        onPressed: () {}),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
