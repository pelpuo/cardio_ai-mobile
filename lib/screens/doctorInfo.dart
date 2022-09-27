import 'package:cardio_ai/screens/schedule.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:cardio_ai/widgets/recentCard.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({Key? key}) : super(key: key);

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
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

    return Scaffold(
      body: Column(
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
                        const Text(
                          "Dr. Kwame Ansah",
                          style: TextStyle(
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
                              "Trust Hospital",
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "About",
                  style: TextStyle(
                    fontSize: 24,
                    color: appColors.textBlack,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Has 9 years experience in Cardiac Sarcoidosis.",
                  style: TextStyle(
                    fontSize: 16,
                    color: appColors.appGrey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          // Availability Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Availability",
                  style: TextStyle(
                    fontSize: 24,
                    color: appColors.textBlack,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: appColors.blue,
                  selectedTextColor: appColors.appWhite,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
              ],
            ),
          ),
          // Recent Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Recent",
                    style: TextStyle(
                      fontSize: 24,
                      color: appColors.textBlack,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See all",
                        style: TextStyle(color: appColors.pink, fontSize: 16),
                      ))
                ]),
          ),

          const SizedBox(
            height: 6,
          ),
          Flexible(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: patients.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 12),
                    child: RecentCard(
                      name: patients[index],
                      condition: "Atrial Fibrilation",
                      date: "3 days ago",
                    ),
                  );
                }),
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        backgroundColor:
                            MaterialStateProperty.all(appColors.blue)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Schedule()));
                    },
                    child: const Text(
                      "Edit Availability",
                      style: TextStyle(color: appColors.appWhite, fontSize: 16),
                    )),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
