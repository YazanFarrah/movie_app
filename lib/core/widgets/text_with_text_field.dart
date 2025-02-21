import 'package:get/get.dart' hide Trans;
import 'package:movie_app/core/widgets/custom_form_field.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWithTextField extends StatefulWidget {
  const TextWithTextField({
    super.key,
    required this.text,
    required this.controller,
    this.textStyle,
    this.errorString,
    this.hintText,
    this.isPass,
    this.keyType,
    this.maxLength,
    this.maxLines = 1,
    this.radius,
    this.contentPadding,
    this.verticalPadding,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onChanged,
    this.filled = true,
    this.fillColor,
    this.hasBorderSide = true,
    this.enabled,
    this.width = double.infinity,
    this.suffix,
    this.prefix,
    this.numbersOnly,
    this.showErrorString = false,
  });

  final String text;
  final TextStyle? textStyle;
  final TextEditingController controller;
  final String? errorString;
  final String? hintText;
  final bool? isPass;
  final TextInputType? keyType;
  final int? maxLength;
  final int? maxLines;
  final double? radius;
  final double? contentPadding;
  final double? verticalPadding;
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final dynamic Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool? filled;
  final Color? fillColor;
  final bool? hasBorderSide;
  final bool? enabled;
  final double? width;
  final Widget? suffix;
  final Widget? prefix;
  final bool? numbersOnly;
  final bool? showErrorString;

  @override
  State<TextWithTextField> createState() => _TextWithTextFieldState();
}

class _TextWithTextFieldState extends State<TextWithTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.errorString != null
              ? Row(
                  children: [
                    CustomTextWidget(
                      text: widget.text,
                      fontWeight: FontWeight.w500,
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: CustomTextWidget(
                        text: widget.errorString!,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              : CustomTextWidget(
                  text: widget.text,
                  fontWeight: FontWeight.w500,
                ),
          SizedBox(height: 5.h),
          SizedBox(
            width: widget.width ?? MediaQuery.of(context).size.width * 0.4,
            child: CustomFormField(
              hintText: widget.hintText,
              controller: widget.controller,
              isPass: widget.isPass,
              maxLines: widget.maxLines,
              keyType: widget.keyType,
              maxLength: widget.maxLength,
              radius: widget.radius,
              numbersOnly: widget.numbersOnly,
              contentPadding: widget.contentPadding ?? 10,
              verticalPadding: widget.verticalPadding,
              validator: widget.validator,
              focusNode: widget.focusNode,
              onEditingComplete: widget.onEditingComplete,
              onFieldSubmitted: widget.onFieldSubmitted,
              onChanged: (widget.onChanged != null)
                  ? widget.onChanged
                  : (widget.errorString != null)
                      ? (p0) {
                          setState(() {});
                        }
                      : null,
              filled: widget.filled,
              filledColor: widget.fillColor ?? Get.theme.colorScheme.onSurface,
              hasBorderSide: widget.hasBorderSide,
              enabled: widget.enabled,
              suffix: widget.suffix,
              prefix: widget.prefix,
              showErrorString: widget.showErrorString,
            ),
          ),
        ],
      ),
    );
  }
}
