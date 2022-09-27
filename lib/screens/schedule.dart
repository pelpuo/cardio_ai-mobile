import 'package:cardio_ai/styles/colors.dart';
import 'package:cardio_ai/widgets/scheduleCard.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
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
    return Scaffold(
        backgroundColor: appColors.offWhite,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Schedule",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Flexible(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: patients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ScheduleCard(),
                      );
                    }),
              )
            ],
          ),
        )));
  }
}
