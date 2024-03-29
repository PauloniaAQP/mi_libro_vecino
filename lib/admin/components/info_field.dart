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
        if (maxLines == 1)
          SizedBox(
            height: 50,
            child: Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.bottom,
              thickness: 3,
              interactive: true,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFFF9F9F9),
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: maxLines,
                    ),
                  ),
                  suffixIcon ?? const SizedBox(),
                ],
              ),
            ),
          )
        else
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
                      hintStyle:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
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
