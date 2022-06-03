import 'package:badge_system/core/constants/colors.dart';
import 'package:badge_system/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.labelText,
      required this.textController,
      required this.obscureText,
      required this.enabledIcons,
      this.padding,
      this.enabled,
      this.helper,
      this.width,
      this.selecableEn,
      this.inputFormatters,
      this.maxLength,
      this.focusNode,
      this.autofocus,
      this.colorIcon,
      this.onChanged,
      this.visibIconsTap,
      this.expandHeight,
      this.errorText,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType})
      : super(key: key);

  final Function(String)? onChanged;

  final Function()? visibIconsTap;
  final bool? autofocus;
  final Color? colorIcon;
  final bool? enabled;
  final bool enabledIcons;
  final String? errorText;
  final double? expandHeight;
  final FocusNode? focusNode;
  final String? helper;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String labelText;
  final int? maxLength;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController textController;
  final double? width;
  final bool? selecableEn;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: padding ?? EdgeInsets.only(bottom: bottomPadding),
      child: TextFormField(
          textAlign: TextAlign.right,
          enableInteractiveSelection: true,
          onChanged: onChanged,
          enabled: enabled,
          focusNode: focusNode,
          autofocus: (autofocus != null) ? true : false,
          style: TextStyle(
            height: expandHeight ?? 2.5,
            fontSize: normalFontSize,
          ),
          minLines: 1,
          maxLength: maxLength,
          onTap: selecableEn != null
              ? selecableEn!
                  ? () {
                      textController.selection = TextSelection(baseOffset: 0, extentOffset: textController.text.length);
                    }
                  : null
              : null,
          textInputAction: TextInputAction.next,
          inputFormatters: inputFormatters,
          controller: textController,
          obscuringCharacter: '*',
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLengthEnforcement: MaxLengthEnforcement.none,
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black26,
              ),
            ),
            errorText: errorText,
            errorStyle: TextStyle(fontSize: normalFontSize, color: Colors.red),
            filled: true,
            fillColor: Colors.white,
            focusColor: darkBule,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon ??
                Visibility(
                  visible: enabledIcons,
                  child: IconButton(
                    padding: EdgeInsets.only(left: 15.sp),
                    onPressed: visibIconsTap,
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      size: smallIconSize,
                      color: colorIcon,
                    ),
                  ),
                ),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius), borderSide: BorderSide(color: diffualtColor, width: 1.8)),
            helperText: helper,
            helperStyle: TextStyle(
              color: Colors.green,
              fontSize: expandHeight != null ? bigFontSize : normalFontSize,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            helperMaxLines: 5,
            labelStyle: TextStyle(fontSize: expandHeight != null ? bigFontSize : normalFontSize, color: Colors.grey[500]),
            labelText: labelText,
          )),
    );
  }
}
