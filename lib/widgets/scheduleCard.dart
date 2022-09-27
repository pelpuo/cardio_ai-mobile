import 'package:cardio_ai/screens/doctorInfo.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: appColors.appWhite, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sandra Addo",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Post-Op Patient",
                      style: TextStyle(fontSize: 12, color: appColors.appGrey),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.punch_clock,
                                color: appColors.appGrey,
                              ),
                              Text(
                                "10:00AM",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.calendar_month,
                                color: appColors.appGrey,
                              ),
                              Text(
                                "12/09/22",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.check,
                                color: appColors.blue,
                              ),
                              Text(
                                "10:00AM",
                                style: TextStyle(
                                    fontSize: 12, color: appColors.blue),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage("assets/avatar.png"),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: appColors.blue)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 14, color: appColors.blue),
                      )),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(appColors.blue),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoctorInfo()));
                      },
                      child: const Text(
                        "Reschedule",
                        style:
                            TextStyle(fontSize: 14, color: appColors.appWhite),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
