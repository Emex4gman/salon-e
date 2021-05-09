import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_e/util/style/theme.dart';

class CustomInputField extends StatefulWidget {
  final String? field;
  final TextEditingController? textController;
  final bool? hideText;
  final String? label;
  final String? Function(String?)? validator;
  final bool showErr;
  final double borderRad;

  final FocusNode? focusNode;
  const CustomInputField({
    this.field,
    Key? key,
    this.borderRad = 5.0,
    this.focusNode,
    this.showErr = true,
    this.validator,
    this.textController,
    this.label,
    this.hideText,
  }) : super(key: key);
  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> with WidgetsBindingObserver {
  late Map responce;
  late String label;
  bool _obscureText = true;

  late String finalValue;

  @override
  void initState() {
    super.initState();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: TextFormField(
        controller: widget.textController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: widget.focusNode,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppTheme.dark,
          fontSize: 14,
        ),
        obscureText: widget.hideText != null ? _obscureText : false,
        validator: widget.validator,
        keyboardType: widget.field == 'number'
            ? TextInputType.phone
            : widget.field == 'amount'
                ? TextInputType.number
                : widget.field == "email"
                    ? TextInputType.emailAddress
                    : null,
        inputFormatters: widget.field == 'number' ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : null,
        decoration: InputDecoration(
          suffixIcon: widget.hideText != null
              ? IconButton(
                  onPressed: () {
                    _toggleObscureText();
                  },
                  icon: Icon(
                    _obscureText ? Icons.remove_red_eye : Icons.visibility_off,
                    color: Theme.of(context).buttonColor,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(left: 10, top: 10),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          hintText: widget.label,
          labelText: widget.label,
          labelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFFBDBDBD),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          errorStyle: widget.showErr ? const TextStyle(fontSize: 8, fontWeight: FontWeight.w500, height: .5) : const TextStyle(fontSize: 0, height: 0),
          errorMaxLines: 1,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.inputBorderFocus, width: 1.5),
            borderRadius: BorderRadius.circular(widget.borderRad),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.inputBorder),
            borderRadius: BorderRadius.circular(widget.borderRad),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.inputBorder,
            ),
            borderRadius: BorderRadius.circular(
              widget.borderRad,
            ),
          ),
        ),
      ),
    );
  }
}
