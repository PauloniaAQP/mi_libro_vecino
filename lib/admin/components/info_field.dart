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
        Container(
          color: const Color(0xFFF9F9F9),
          height: 32 + (maxLines * 24),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: PColors.black,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLines,
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
