import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    Key? key,
    required this.onTap,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  final Function() onTap;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 5,
      ),
      child: RawMaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        onPressed: onTap,
        fillColor:
            isSelected ? const Color(0xFF2183DF) : PColors.gray4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : PColors.gray1,
          ),
        ),
      ),
    );
  }
}
