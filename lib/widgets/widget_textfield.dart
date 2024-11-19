// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/shared/uicolor.dart';

class BasicTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? nextFocus;
  final TextEditingController? controller;
  final FontWeight fontWeight;
  final int? maxLength;
  final int? minLines;
  final double? fontSize;
  final String? labelText;
  final int? maxLines;
  final double? height;
  final bool? enabled;
  final bool? autoFocus;
  final bool? isFloating;
  final bool obscureText;
  final double? radius;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isEnabled;
  final bool isBorder;
  final bool isTransparent;
  final Color? color;
  final Color? borderColor;
  final Color? labelColor;
  final Color? hintColor;
  final TextCapitalization? textCapitalization;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;

  // ignore: use_key_in_widget_constructors
  const BasicTextField(
      {this.focusNode,
      this.keyboardType,
      this.textInputAction,
      this.nextFocus,
      this.fontSize,
      this.controller,
      this.fontWeight = FontWeight.w400,
      this.obscureText = false,
      this.maxLength,
      this.minLines,
      this.maxLines,
      this.textCapitalization,
      this.labelText = "",
      this.height,
      this.autoFocus,
      this.isFloating = true,
      this.color,
      this.enabled,
      this.isEnabled,
      this.isBorder = false,
      this.radius,
      this.hint,
      this.isTransparent = true,
      this.prefixIcon,
      this.borderColor,
      this.labelColor,
      this.hintColor,
      this.onChanged,
      this.onSubmitted,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 48,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 6),
            color: color,
            border: isTransparent
                ? Border.all(color: Colors.transparent)
                : isBorder == true && isEnabled == false
                    ? Border.all(width: 1, color: UIColor.primary)
                    : Border.all(width: 1, color: UIColor.formField)),
        child: TextFormField(
          enabled: enabled,
          textCapitalization: textCapitalization ?? TextCapitalization.sentences,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: autoFocus ?? false,
          cursorColor: UIColor.formField,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: (v) {
            if (onSubmitted != null) onSubmitted!(v);
          },
          maxLength: maxLength,
          minLines: minLines,
          keyboardType: keyboardType,
          style: TextStyle(
            color: labelColor ?? UIColor.black,
            fontSize: fontSize ?? 13,
            fontWeight: fontWeight,
            decoration: TextDecoration.none,
          ),
          controller: controller,
          onChanged: (value) {
            if (onChanged != null) onChanged!(value);
          },
          decoration: InputDecoration(
              fillColor: color,
              floatingLabelBehavior: isFloating == true ? FloatingLabelBehavior.always : FloatingLabelBehavior.never,
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              labelText: labelText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hint,
              hintStyle: TextStyle(color: hintColor ?? UIColor.hintText, fontSize: 13, fontWeight: FontWeight.w400),
              errorStyle: TextStyle(color: UIColor.red, height: 0.3, fontSize: 9),
              border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: borderColor ?? UIColor.formField)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(width: 1, color: UIColor.formField)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(width: 1, color: UIColor.formField))),
        ));
  }
}
