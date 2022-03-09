import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../global_features/color_manager.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final bool? multiLines;
  final TextInputAction? textInputAction;

  const PrimaryTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.prefixIcon,
      this.onTap,
      this.readOnly = false,
      this.onFieldSubmitted,
      this.suffixIcon,
      this.multiLines = false,
      this.textInputAction = TextInputAction.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 50,
      child: Material(
          shadowColor: ColorManager.shadowColor,
          elevation: 4,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            textInputAction: textInputAction,
            maxLines: multiLines! ? 10 : 1,
            cursorColor: ColorManager.fontColor,
            style: TextStyle(color: ColorManager.fontColor),
            keyboardType: keyboardType,
            onTap: onTap ?? () {},
            onFieldSubmitted: onFieldSubmitted ?? (v) {},
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hintText!.isNotEmpty ? hintText!.tr : '',
              hintStyle: TextStyle(
                color: ColorManager.grey,
                fontSize: 14.sp,
              ),
              filled: true,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              fillColor: Colors.white,
            ),
            validator: validator,
          )),
    );
  }
}
