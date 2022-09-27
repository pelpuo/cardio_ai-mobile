import 'package:cardio_ai/styles/colors.dart';
import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String email;
  final String gender;
  final Function viewResults;
  final Function bookAppointment;
  const PatientCard(
      {Key? key,
      required this.name,
      required this.viewResults,
      required this.bookAppointment,
      required this.email,
      required this.gender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          color: appColors.appWhite, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: appColors.blue,
              // backgroundImage: AssetImage(imageLink),
              child: Text(
                name[0],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: appColors.appWhite),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Text(
                  email,
                  style:
                      const TextStyle(fontSize: 14, color: appColors.appGrey),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Icon(
                      gender == "male" ? Icons.male : Icons.female,
                      size: 14,
                      color: gender == "male" ? appColors.blue : appColors.pink,
                    ),
                    Text(
                      gender,
                      style: const TextStyle(
                          color: appColors.appGrey, fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
          IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                      backgroundColor:
                          MaterialStateProperty.all(appColors.blue),
                    ),
                    onPressed: () {
                      viewResults();
                    },
                    child: const Text(
                      "View ECG results",
                      style: TextStyle(color: appColors.appWhite, fontSize: 10),
                    )),
                // TextButton(
                //     style: ButtonStyle(
                //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(30))),
                //       backgroundColor:
                //           MaterialStateProperty.all(appColors.blue),
                //     ),
                //     onPressed: () {
                //       bookAppointment();
                //     },
                //     child: const Text(
                //       "Book an appointment",
                //       style: TextStyle(color: appColors.appWhite, fontSize: 10),
                //     )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
