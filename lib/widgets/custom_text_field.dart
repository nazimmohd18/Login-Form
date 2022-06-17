import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import '../utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String? initialValue;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final double? textHeight;
  final double? width;
  final int? maxLines;
  final int? maxLength;
  final Color? textColor;
  final String? labelText;
  final double? letterSpacing;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String)? onChanged;
  final BoxBorder? border;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  const CustomTextField({
    Key? key,
    required this.title,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.height,
    this.width,
    this.maxLines = 1,
    this.maxLength,
    this.letterSpacing = 0.25,
    this.textHeight,
    this.controller,
    this.initialValue,
    this.inputFormatter,
    this.textColor = greyColor,
    this.onChanged,
    this.border,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
    this.labelText,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _textFieldFocus = FocusNode();
  Color _color = whiteColor;
  Color _onEditingCompleteColor = const Color(0xFF959E9F);

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      setState(() {
        _onEditingCompleteColor = blackColor;
      });
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = whiteColor;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: widget.height,
        width: widget.width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: widget.border),
        child: TextFormField(
          obscureText: widget.obscureText,
          obscuringCharacter: "*",
          inputFormatters: widget.inputFormatter,
          initialValue: widget.initialValue,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          maxLength: widget.maxLength,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          focusNode: _textFieldFocus,
          cursorColor: blackColor,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              // filled: true,
              fillColor: _color,
              counterText: "",
              labelText: widget.labelText,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _onEditingCompleteColor),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: blackColor),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              contentPadding: const EdgeInsets.only(left: 14),
              border: InputBorder.none,
              hintText: widget.title,
              hintStyle: TextStyle(
                height: widget.textHeight,
                color: widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: widget.letterSpacing,
              ),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 20,
                maxWidth: 40,
              )),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
