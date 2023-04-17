import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool? obscureText;
  final bool withOutPadding;
  final Widget? suffixIcon;
  final bool isEnabled;
  final bool disableClick;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final int maxLines;
  final int minLines;
  final String? prefixText;

  const AppTextFormField(
      {this.isEnabled = true,
      this.withOutPadding = false,
      this.controller,
      this.obscureText,
      this.disableClick = false,
      this.suffixIcon,
      this.minLines = 1,
      this.prefixText,
      this.maxLines = 5,
      this.onFieldSubmitted,
      this.borderRadius = AppDimen.radiusMedium,
      this.contentPadding,
      this.textInputAction,
      required this.placeholder,
      this.validator,
      this.initialValue,
      this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      initialValue: initialValue,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? false,
      validator: validator,
      textInputAction: textInputAction,
      style: AppTextStyle.regular(),
      decoration: InputDecoration(
        prefixText: prefixText,
        prefixStyle: AppTextStyle.regular(),
        isDense: true,
        contentPadding: contentPadding ??
            (withOutPadding
                ? const EdgeInsets.symmetric(
                    vertical: AppDimen.paddingSmall,
                    horizontal: AppDimen.paddingMedium)
                : null),
        hintText: placeholder,
        hintStyle: AppTextStyle.light(color: Colors.black38),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        // labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: disableClick
            ? AppColor.grayLight
            : (isEnabled ? AppColor.grayLight : Colors.black26),
        errorStyle: AppTextStyle.light(color: AppColor.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColor.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColor.grayDark),
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: AppDimen.iconSizeMax,
          maxWidth: AppDimen.iconSizeMax,
        ),
      ),
    );
  }
}
