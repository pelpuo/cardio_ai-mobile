import 'package:cardio_ai/providers/patientProvider.dart';
import 'package:cardio_ai/screens/Profile.dart';
import 'package:cardio_ai/screens/detection.dart';
import 'package:cardio_ai/screens/ecgMonitoring.dart';
import 'package:cardio_ai/screens/findPatient.dart';
import 'package:cardio_ai/screens/schedule.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:cardio_ai/widgets/dashboardBtn.dart';
import 'package:cardio_ai/wrappers/authWrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cardio_ai/providers/authProvider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String doctorName = "Dr. Ansah";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAppVars();
  }

  setAppVars() async {
    var accessToken = await Provider.of<PatientProvider>(context, listen: false)
        .getAccessToken();
    Provider.of<PatientProvider>(context, listen: false)
        .getCurrentUser(token: accessToken);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.offWhite,
      body: Consumer<PatientProvider>(
        builder: (context, patientBase, child) => SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome back, ${patientBase.currentUser?.firstName ?? ""} ${patientBase.currentUser?.lastName ?? ""}",
                    style: const TextStyle(
                        fontSize: 18, color: appColors.textBlack),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Image.asset(
                  "assets/dashboard_waveform.png",
                  height: 150,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Activity",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    DashboardBtn(
                      backgroundColor: const Color(0xffFEF1DD),
                      foregroundColor: const Color(0xffF9B853),
                      icon: "assets/patients.png",
                      label: "Total Patients",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FindPatient()));
                      },
                    ),
                    DashboardBtn(
                      backgroundColor: const Color(0xffE6EEFF),
                      foregroundColor: const Color(0xff0659FD),
                      icon: "assets/ecg_monitoring.png",
                      label: "ECG Monitoring",
                      onPressed: () {
                        patientBase.deleteAccessToken();
                        Provider.of<AuthProvider>(context, listen: false)
                            .setSignedIn(false);
                        Provider.of<AuthProvider>(context, listen: false)
                            .setAuthState("signIn");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AuthWrapper()));
                      },
                    ),
                    DashboardBtn(
                      backgroundColor: const Color(0xffDDF7E1),
                      foregroundColor: const Color(0xff53D769),
                      icon: "assets/appointments.png",
                      label: "My Profile",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()));
                      },
                    ),
                    DashboardBtn(
                      backgroundColor: const Color(0xffdee1fc),
                      foregroundColor: const Color(0xffA5A6F6),
                      icon: "assets/classification.png",
                      label: "Detection and Classification",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Detection()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
