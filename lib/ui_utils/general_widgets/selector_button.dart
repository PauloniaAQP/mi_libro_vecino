import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class SelectorButton extends StatelessWidget {
  const SelectorButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? PColors.gray3 : Colors.transparent,
        width: double.infinity,
        height: 108,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 20,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: isSelected,
              child: Container(
                color: PColors.blue,
                width: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
