import 'package:flutter/material.dart';

class CustomFormFields extends StatelessWidget {
  final bool enabled;
  final bool obscureText;
  final IconData prefixIcon;
  final String hintText;
  final String label;
  final int maxNumOfCharacters;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final FocusNode focusTo;
  final String Function(String) validatorFunction;
  final Function(String) onSaveFunction;

  CustomFormFields({
    Key key,
    this.enabled = true,
    this.obscureText = false,
    this.prefixIcon,
    this.hintText = "Hint text",
    this.label,
    this.maxNumOfCharacters,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textEditingController,
    this.focusNode,
    this.focusTo,
    this.validatorFunction,
    this.onSaveFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: this.enabled,
      cursorColor: Colors.grey[900],
      style: TextStyle(
        color: Colors.grey[900],
      ),
      controller: textEditingController,
      focusNode: focusNode,
      maxLength: maxNumOfCharacters,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: buildInputDecoration(prefixIcon, hintText),
      onFieldSubmitted: (String value) {
        if (focusTo != null) {
          FocusScope.of(context).requestFocus(focusTo);
        }
      },
      validator: validatorFunction,
      onSaved: onSaveFunction,
    );
  }

  InputDecoration buildInputDecoration(IconData icon, String hintText) {
    return InputDecoration(
      prefixIcon: (icon != null)
          ? Icon(
              icon,
              color: Colors.blueGrey[700],
            )
          : null,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.blueGrey[800],
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.blueGrey[200],
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.blueGrey[500],
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.red,
        ),
      ),
      errorStyle: TextStyle(color: Colors.redAccent[200]),
      hintText: hintText,
      counterText: "",
      hintStyle: TextStyle(
        color: Colors.blueGrey[700],
      ),
      labelStyle: TextStyle(
        color: Colors.blueGrey[900],
      ),
      labelText: label,
    );
  }
}
