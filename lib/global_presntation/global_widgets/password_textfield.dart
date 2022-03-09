import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../global_features/color_manager.dart';

class PasswordTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onFieldSubmitted;

  const PasswordTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.validator,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //    height: 50,
      child: Material(
          shadowColor: ColorManager.shadowColor,
          elevation: 4,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: TextFormField(
            controller: widget.controller,
            cursorColor: ColorManager.fontColor,
            style: TextStyle(color: ColorManager.fontColor),
            keyboardType: TextInputType.visiblePassword,
            obscureText: !visiblePassword,
            onFieldSubmitted: widget.onFieldSubmitted ?? (v) {},
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: ColorManager.accent,
                size: 23.w,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    visiblePassword = !visiblePassword;
                  });
                },
                icon: visiblePassword
                    ? Icon(
                        Icons.visibility_off,
                        color: ColorManager.accent,
                      )
                    : Icon(
                        Icons.visibility,
                        color: ColorManager.accent,
                      ),
              ),
              hintText: widget.hintText!.isNotEmpty ? widget.hintText!.tr : '',
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
            validator: widget.validator,
          )),
    );
  }
}
