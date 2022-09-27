import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class InfoField extends StatelessWidget {
  const InfoField({
    Key? key,
    this.hintText = '',
    required this.label,
    this.suffixIcon,
    required this.text,
    this.maxLines = 1,
  }) : super(key: key);

  final String label;
  final String text;
  final String? hintText;
  final Widget? suffixIcon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: PColors.gray1,
                ),
          ),
        ),
        // TODO(oscarnar): Corregir el scroll bar para textos de una linea (scroll horizontal)
        // Scrollbar(
        //   scrollbarOrientation: ScrollbarOrientation.bottom,
        //   // isAlwaysShown: maxLines == 1,
        //   thickness: 6,
        //   child: SingleChildScrollView(
        //     scrollDirection: Axis.horizontal,
        //     child: Row(
        //       children: [
        //         Container(
        //           color: Colors.red,
        //           height: 20,
        //           width: 500,
        //         ),
        //         Container(
        //           color: Colors.blue,
        //           height: 20,
        //           width: 500,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFFF9F9F9),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  enabled: true,
                  maxLines: maxLines,
                  minLines: 1,
                  readOnly: true,
                  controller: TextEditingController(text: text),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: PColors.gray1,
                        ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              suffixIcon ?? const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
