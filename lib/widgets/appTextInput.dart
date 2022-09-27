import 'package:flutter/material.dart';
import 'package:cardio_ai/styles/colors.dart';

class AppTexInput extends StatelessWidget {
  final TextEditingController textController;
  final Function onPressed;
  final TextInputType keyboardType;
  final IconData? textIcon;
  final String prompt;
  final FocusNode? focusNode;
  final bool hideText;
  final bool? autofocus;
  const AppTexInput(
      {Key? key,
      required this.textController,
      required this.prompt,
      required this.onPressed,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.autofocus,
      this.hideText = false,
      this.textIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prompt,
          style: const TextStyle(fontSize: 16, color: appColors.appGrey),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
            obscureText: hideText,
            focusNode: focusNode,
            autofocus: autofocus ?? false,
            controller: textController,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 16, color: appColors.textDark),
            onTap: () {
              onPressed();
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: appColors.appGrey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: appColors.appGrey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              fillColor: appColors.offWhite,
              filled: true,
              // hintText: prompt,
              // hintStyle: TextStyle(color: appColors.appGrey)),
            ))
      ],
    );
  }
}
