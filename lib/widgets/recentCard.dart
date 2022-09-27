import 'package:cardio_ai/styles/colors.dart';
import 'package:flutter/material.dart';

class RecentCard extends StatelessWidget {
  final String name;
  final String date;
  final String condition;
  const RecentCard(
      {Key? key,
      required this.name,
      required this.condition,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * .75,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appColors.appWhite,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage("assets/avatar.png"),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "David Mensah",
              style: TextStyle(color: appColors.blue, fontSize: 16),
            ),
            // Text(
            //   "3 days ago",
            //   style: TextStyle(color: appColors.appGrey, fontSize: 12),
            // ),
            // SizedBox(
            //   height: 6,
            // ),
            Text(
              "QT Interval shortened",
              style: TextStyle(color: appColors.textBlack, fontSize: 12),
            )
          ],
        )
      ]),
    );
  }
}
