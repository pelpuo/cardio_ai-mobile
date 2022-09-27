import 'package:cardio_ai/models/EcgReading.dart';
import 'package:cardio_ai/models/Patient.dart';
import 'package:cardio_ai/providers/authProvider.dart';
import 'package:cardio_ai/providers/patientProvider.dart';
import 'package:cardio_ai/screens/ecgDisplay.dart';
import 'package:cardio_ai/screens/ecgMonitoring.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:cardio_ai/widgets/EcgResultsCard.dart';
import 'package:cardio_ai/widgets/patientCard.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PatientResults extends StatefulWidget {
  const PatientResults({Key? key}) : super(key: key);

  @override
  State<PatientResults> createState() => _PatientResultsState();
}

class _PatientResultsState extends State<PatientResults> {
  String errors = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveReadings();
  }

  retrieveReadings() async {
    List<EcgReading> temp =
        await Provider.of<PatientProvider>(context, listen: false)
            .getEcgReadings();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // List temp =
  }

  String getAge(String birthdate) {
    int currentYear = DateTime.now().year.toInt();
    int birthYear = int.parse(birthdate.split("/")[2].trim());
    int age = currentYear - birthYear;
    return age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: appColors.textBlack,
      ),
      backgroundColor: appColors.offWhite,
      body: Consumer<PatientProvider>(
        builder: (context, patientBase, child) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: appColors.appWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: appColors.blue,
                            child: Icon(
                              Icons.person,
                              size: 28,
                              color: appColors.appWhite,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${patientBase.currentPatient!.lastName}, ${patientBase.currentPatient!.firstName}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: appColors.textDark),
                                ),
                                Text(
                                  patientBase.currentPatient!.email,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.blue),
                                ),
                              ])
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Born: ${patientBase.currentPatient!.dateOfBirth}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: appColors.textDark),
                          ),
                          Text(
                            "Age: ${getAge(patientBase.currentPatient!.dateOfBirth)}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: appColors.textDark),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            "Gender: ${patientBase.currentPatient!.gender}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: appColors.textDark),
                          ),
                          Icon(
                            patientBase.currentPatient!.gender
                                        .toLowerCase()
                                        .trim() ==
                                    "male"
                                ? Icons.male
                                : Icons.female,
                            color: patientBase.currentPatient!.gender
                                        .toLowerCase()
                                        .trim() ==
                                    "male"
                                ? appColors.blue
                                : appColors.pink,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ECG Results:",
                    style: TextStyle(
                        fontSize: 16,
                        color: appColors.appGrey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                patientBase.loadingReadings
                    ? const Expanded(
                        child: SpinKitFadingFour(
                        color: appColors.blue,
                      ))
                    : patientBase.patients.isEmpty
                        ? const Center(child: Text("No patients assigned"))
                        : Flexible(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                var temp = await patientBase.getPatients(
                                    refresh: true);
                                setState(() {
                                  patientBase.getEcgReadings();

                                  print("Refreshing patients");
                                });
                              },
                              child: patientBase.patientReadings.isEmpty
                                  ? const Text(
                                      "No readings for current patient",
                                      style:
                                          TextStyle(color: appColors.appGrey),
                                    )
                                  : RefreshIndicator(
                                      onRefresh: () async {},
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: patientBase
                                              .patientReadings.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: EcgResultsCard(
                                                    onTap: () async {
                                                      patientBase.setCurrentReading(
                                                          patientBase
                                                                  .patientReadings[
                                                              index]);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const EcgDisplay()));
                                                    },
                                                    prediction: "Normal",
                                                    date: patientBase
                                                        .patientReadings[index]
                                                        .createdAt,
                                                    hospital: patientBase
                                                        .patientReadings[index]
                                                        .hospitalName,
                                                    leadType: patientBase
                                                        .patientReadings[index]
                                                        .leadType,
                                                    leadPlacement: patientBase
                                                        .patientReadings[index]
                                                        .leadPlacement));
                                          }),
                                    ),
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
