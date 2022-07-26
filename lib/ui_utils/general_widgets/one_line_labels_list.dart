import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

/// Build a list of labels, but in one line.
/// If the list is too long, it will be show a bubble.
class OneLineLabelsList extends StatelessWidget {
  const OneLineLabelsList({
    Key? key,
    required this.labelsList,
  }) : super(key: key);

  final List<String> labelsList;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        var _widthNeeded = 0;
        var _maxIndex = 0;
        for (final label in labelsList) {
          _widthNeeded += (label.length * 7) + 58;
          if (_widthNeeded > constraints.maxWidth) {
            // If we have less space than the bubble (30),
            // we need to rest one label
            if (constraints.maxWidth -
                    (_widthNeeded - (label.length * 7) - 48) <
                30) {
              _maxIndex--;
            }
            break;
          }
          _maxIndex++;
        }
        return Row(
          children: [
            ...List.generate(
              _maxIndex,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Chip(
                  label: Text(labelsList[index]),
                ),
              ),
            ),
            Visibility(
              visible: labelsList.length > _maxIndex,
              child: CircleAvatar(
                backgroundColor: PColors.blue,
                radius: 15,
                child: Text(
                  '+${labelsList.length - _maxIndex}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
