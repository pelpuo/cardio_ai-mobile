import 'package:cardio_ai/styles/colors.dart';
import 'package:flutter/material.dart';

class DashboardBtn extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String icon;
  final double iconWidth;
  final String label;
  final Function onPressed;
  const DashboardBtn(
      {Key? key,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.icon,
      required this.label,
      this.iconWidth = 24,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(16)),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: appColors.offWhite,
                      borderRadius: BorderRadius.circular(24)),
                  child: Image.asset(
                    icon,
                    width: iconWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    label,
                    style: TextStyle(color: foregroundColor, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
