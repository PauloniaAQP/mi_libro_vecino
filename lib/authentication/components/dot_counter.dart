import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class DotCounter extends StatelessWidget {
  const DotCounter({
    Key? key,
    required this.length,
    required this.index,
  }) : super(key: key);

  final int length;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int current = 0; current < length; current++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: (current == index)
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : PColors.gray4,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
        ],
      ),
    );
  }
}
