import 'package:cardio_ai/screens/doctorInfo.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:flutter/material.dart';

class EcgResultsCard extends StatelessWidget {
  final String prediction;
  final String date;
  final String hospital;
  final String leadType;
  final Function onTap;
  final String leadPlacement;
  const EcgResultsCard(
      {Key? key,
      required this.prediction,
      required this.onTap,
      required this.date,
      required this.hospital,
      required this.leadType,
      required this.leadPlacement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String splitDate = date.substring(0, 10);
    String splitTime = date.substring(11, 19);
    List<String> dateParts = splitDate.split("-");

    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appColors.appWhite,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${dateParts[2]}/${dateParts[1]}/${dateParts[0]}",
                              style: const TextStyle(
                                  fontSize: 14, color: appColors.appGrey),
                            ),
                            Text(
                              splitTime,
                              style: const TextStyle(
                                  fontSize: 14, color: appColors.appGrey),
                            ),
                          ]),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Prediction: $prediction",
                        style: const TextStyle(
                            fontSize: 14,
                            color: appColors.blue,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        hospital,
                        style: const TextStyle(
                            fontSize: 16,
                            color: appColors.textDark,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Lead Type:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: appColors.textDark,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  leadType,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: appColors.textDark,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Placement:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: appColors.textDark,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  leadPlacement,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: appColors.textDark,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
