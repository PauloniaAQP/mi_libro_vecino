import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PTextField extends StatelessWidget {
  const PTextField({
    Key? key,
    required this.formControlName,
    required this.hintText,
    required this.label,
    this.validationMessages,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.mouseCursor,
  }) : super(key: key);

  final String label;
  final String hintText;
  final Map<String, String>? validationMessages;
  final TextInputType? keyboardType;
  final String formControlName;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: PColors.gray1,
                ),
          ),
        ),
        ReactiveTextField<String>(
          formControlName: formControlName,
          validationMessages: (control) => validationMessages ?? {},
          keyboardType: keyboardType,
          textCapitalization: TextCapitalization.words,
          obscureText: obscureText,
          obscuringCharacter: '*',
          readOnly: readOnly,
          mouseCursor: mouseCursor,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xffF9F9F9),
            hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: PColors.gray4,
                ),
            suffixIcon: suffixIcon,
          ),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: PColors.black,
              ),
        ),
      ],
    );
  }
}
