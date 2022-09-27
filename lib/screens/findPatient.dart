import 'package:cardio_ai/models/Patient.dart';
import 'package:cardio_ai/providers/authProvider.dart';
import 'package:cardio_ai/providers/patientProvider.dart';
import 'package:cardio_ai/screens/patientResults.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:cardio_ai/widgets/patientCard.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindPatient extends StatefulWidget {
  const FindPatient({Key? key}) : super(key: key);

  @override
  State<FindPatient> createState() => _FindPatientState();
}

class _FindPatientState extends State<FindPatient> {
  TextEditingController searchController = TextEditingController();
  List<Patient> patients = [];
  List<Patient> filteredPatients = [];
  String errors = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrievePatients();
  }

  retrievePatients() async {
    List<Patient> temp =
        await Provider.of<PatientProvider>(context, listen: false)
            .getPatients();

    setState(() {
      patients = temp;
      filteredPatients = temp;
      searchController.text = "";

      print("Setting patients");
    });
  }

  filterPatients(String text) {
    print("Filtering patients");
    List<Patient> temp = patients
        .where((patient) => ("${patient.firstName} ${patient.lastName}")
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase()))
        .toList();
    setState(() {
      filteredPatients = temp;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // List temp =
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
                const Text(
                  "Find your patient",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  onChanged: (text) {
                    filterPatients(text);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      fillColor: appColors.appWhite,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 32,
                      ),
                      prefixIconColor: appColors.textBlack,
                      suffixIcon: const Icon(Icons.menu),
                      hintText: "Search here",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: appColors.appWhite),
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: appColors.appWhite),
                        borderRadius: BorderRadius.circular(45.0),
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "All",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                patientBase.loadingPatients
                    ? Flexible(
                        child: ListView.separated(
                          itemCount: 6,
                          itemBuilder: (context, index) =>
                              const PatientCardSkeleton(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                        ),
                      )
                    : patientBase.patients.isEmpty
                        ? const Center(child: Text("No patients assigned"))
                        : Flexible(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                var temp = await patientBase.getPatients(
                                    refresh: true);
                                setState(() {
                                  patients = temp;
                                  filteredPatients = temp;
                                  searchController.text = "";

                                  print("Refreshing patients");
                                });
                              },
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: filteredPatients.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: PatientCard(
                                          viewResults: () {
                                            patientBase.setCurrentPatient(
                                                filteredPatients[index]);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const PatientResults()));
                                          },
                                          bookAppointment: () {
                                            patientBase.setCurrentPatient(
                                                filteredPatients[index]);
                                          },
                                          name:
                                              "${filteredPatients[index].firstName} ${filteredPatients[index].lastName}",
                                          email: filteredPatients[index].email,
                                          gender:
                                              filteredPatients[index].gender),
                                    );
                                  }),
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

class PatientCardSkeleton extends StatelessWidget {
  const PatientCardSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: appColors.blue.withOpacity(.04),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleSkeleton(
                size: 64,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    height: 24,
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Skeleton(
                    height: 12,
                    width: MediaQuery.of(context).size.width / 4,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Skeleton(
                    height: 12,
                    width: MediaQuery.of(context).size.width / 3,
                  )
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                height: 36,
                width: MediaQuery.of(context).size.width / 3,
              ),
              const SizedBox(
                height: 6,
              ),
              Skeleton(
                height: 36,
                width: MediaQuery.of(context).size.width / 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  final double? height, width;
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: appColors.blue.withOpacity(0.08),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: appColors.blue.withOpacity(0.08),
        shape: BoxShape.circle,
      ),
    );
  }
}
